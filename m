Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C3EC3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 09:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 555C610E379;
	Thu,  8 May 2025 09:33:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g2LEHcjC";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FD1C10E379
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 09:33:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/evut+OR367RI7Yu1mOcOM7Q6XYmp4xTtgEw14Ww0YOLEHPIP8m8Y1gq9Y5vnBNlaNNldauP6wOqHG7oqpJ1jsf/n8LuzHm6aQAN/S2nW11tg0MCCub3nRcb4e2s9rYGqEY/jPj9Zu5ENnS/DohEpu8+S/cm4YjNRBLt6LCOTLjVXUuho3vDUsxsfOB+eq5hP9RNDQvU+jP3nvcDQMQ++aoDcY8LuzyaE9iWfiUoJIUOTiMYw3ruhlc4rJid5SPim6NswYwlSdkKp7rOW2xl/lulVkay9/siz4u9GsZoWgK9kzK5LbQcch3YpTREUdHze7+3kl0uG+9qjp6sI9zEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w19f4DsoWh95obA25hylVjJTav0wvci2sWDkMzmrCe4=;
 b=LOmh+T6gr4sZyckei3VtkF1R0Y36Tff0KIEdsCXgGqwumlwnfvb5B/3vNhMHKJ1mXDsehI1YrHo2zwHOY5tQuGr8QLf5n4AJljqw5g8k9rOFbWzEum/Aku/IqzKw+paas73Yc/gCkt0FktZDr+TvNaeqh2PoN2cu8O5+NCMUjf/ONWx+/gl/Uw5E9M3FYaDJPXwFj8rc3lFHfaoKSuSVWlOMXoxv8z7FBpkSFDqKHuhuqqKr9IazCCaMJ4sYkRbnPheq4hnehEqlvjx07p+A53KTRoM77VrSVRhiKVenyEeqD9Yw98PycswLx0GNrEaXyzSarsZeEP+EOhV2tohs/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w19f4DsoWh95obA25hylVjJTav0wvci2sWDkMzmrCe4=;
 b=g2LEHcjCnWdYlx1ve2QFQ1pbWmMVVve+qTa/esFobwqxKaPSZtDOCz8qXpupN81P2kEaFijV17QtozooDxI1nsjowD7xvs3b7HQHUVAXcHDF1WKBhBfFaITE/O7EP179rfIztWx3l9KNR2YVd6/vl1itiNmTfRuNB71Ud4WkqBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB7821.namprd12.prod.outlook.com (2603:10b6:a03:4d2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 8 May
 2025 09:33:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Thu, 8 May 2025
 09:33:45 +0000
Message-ID: <cc4c665c-6e24-4d0b-b8f8-a482a03ffdbb@amd.com>
Date: Thu, 8 May 2025 11:33:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix NULL dereference in
 amdgpu_userq_restore_worker
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Yadav, Arvind" <Arvind.Yadav@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250508053538.57744-1-Arvind.Yadav@amd.com>
 <BL1PR12MB575323CE3A61B86ADDC8B3AA938BA@BL1PR12MB5753.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <BL1PR12MB575323CE3A61B86ADDC8B3AA938BA@BL1PR12MB5753.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR19CA0064.namprd19.prod.outlook.com
 (2603:10b6:208:19b::41) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: 87206d4c-3958-409b-37aa-08dd8e136dbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzJOYVhkT2dvaEFwRW9VVUszaVJnenpuSXFRWFdMYnFXWVBkZmNaWStwbG8v?=
 =?utf-8?B?L0w4bmpFMFZXeWJMNWduNnpRK2tMazVzcHh1bUdLdHM1UXZyQjAwSXBKSXFr?=
 =?utf-8?B?cUt3UGVxVk9qNzVUOCtWWlNwakJJaDZBVDFWeWQvMTJVVm1pZzFXdUtDTnY3?=
 =?utf-8?B?M0FvRUJRWmVyMU9ZbitVVDVteHUwQkh3anR3OWR2UUtGQWtwOFZzUEVPWmdZ?=
 =?utf-8?B?VGZMTk01Sk9MNFRFQ25Xa2lnckhyVW4rL3hsRGtRemFTbmlrVXhTS3pGdWhC?=
 =?utf-8?B?ek5DcjdHVmxzR1V6Z3phTE8yZTJKL1pMd2FmSnJ3ckZVUU55bGpHZzhSc2FM?=
 =?utf-8?B?czVkVDRuQklJbDhYeUM2aXlzYkx0ZDU1RzUzNkJsSjRyZXlZdE9nc2Y3ZkpS?=
 =?utf-8?B?by8rUjZOZ2hRNjR3UGcwU2hwcXZYVUgxaVlwYkxNYkRGVkMrQWtzeVA5ZFg1?=
 =?utf-8?B?UUR4NEtqOUJ4ZEVVeWp5TE0wSkxjUk81am9kS3llQ3U0OXRtMTZyT3FYQnVM?=
 =?utf-8?B?MGNndENEWHpnQnRpYWhwdngwdzRuSGp4dlpZQVBwN1hTRWprN1ZXa3FSNWNY?=
 =?utf-8?B?ZmJXSkJxRDIzc3hTNGFRUFlMVWVYWkhteCtVUXg4bjZ3VlFDRFBuMGFZOTRI?=
 =?utf-8?B?K2o2ODFNei9UMU5CU2pzYjVMT01uaU5UMVRxVjlCKzlOMjM5VktRUHNhcmVU?=
 =?utf-8?B?b05GYlpWdkFYVnUxMFRpdGg5U2NSVWFiSGhGbm9oRlArVm5FTGlmNTlJYmxr?=
 =?utf-8?B?b2ExTHk4R28xK2UrTTNMU3VMcFJrc2RqMlZZZ1Bvc2EzZW1pL0Z4dnVseTlD?=
 =?utf-8?B?RUxJVEp4UDJxZlFkODdtdVY4aklpeDMzL0hGQmZpZWZjYVlqWm1lUFlybnlX?=
 =?utf-8?B?WFRLbFNvUzNIUEFlQWRyL01SWEVYZy9abHFrTFVRbFhES2l4N0d4ajZlbUxT?=
 =?utf-8?B?dXNZeFJNWk84aEVQT1NmWDNZL1BuRzNSVnlxR2xvMnc5ZlFVcWtWSGt0T1BH?=
 =?utf-8?B?bTcrd3VUc2JXbnpFVThmWnloSUV4Z3FNcUY4dnV3U2dSNlVtWGJGYmpiME5l?=
 =?utf-8?B?Vkpzd3pDR0VoUjd5Vk5BNE5wMFhiVU1teHJmbkZBM1dRZ3Q0WkYzTzJidUhB?=
 =?utf-8?B?Sk1vWEVnT3pzNGdNU2ZSVjdsMnBxZHVXRytJY0dUSGlEeFlWcTlHeDdEYm53?=
 =?utf-8?B?ZzhrNnFxZVNyMmlOSUk3SUgxcHhzL0JEQUtwWXF5ZklrRlZ6eUFpSy9jMm1u?=
 =?utf-8?B?K0IzaWJYNjJkajRZZUx1dGc3djBKVXlXZi9sOWxLd1FoU3JwcWk0K3dGYnNW?=
 =?utf-8?B?dEc0RGxaUU9ZRXFnTm1NZUp4MGNucElaUGI5Sk1HS3lzbWFNbWJmdjcxY2Vu?=
 =?utf-8?B?SDA3TmpPMTlOMWVZNWVsNCtRQzhKUHZCekNYNnZhUHJyekl1N201YTVESDlS?=
 =?utf-8?B?d05YZVhkemZSdSszOWlhRmdjWGFtTWJzM0xoVXhYZG1TaXBDK2IwMVNiVmhw?=
 =?utf-8?B?MUxjMSsxTVlYOXlTekN6MlkyNE5TQllYbnJZdzB5WEVMaS9aMEpaLzdKS2Rj?=
 =?utf-8?B?UUNDMnNmT3VnMWorRTh0czAraUVJOVpuYnJDb21Sd1JpL1pzVHRBQjdsN1BZ?=
 =?utf-8?B?b2RNeDFZdGpCRmJhVm9URll3QnJoTmdmcHNOQUdWMzBjaGYwSEZMbXFQbTdR?=
 =?utf-8?B?eStxYUZNNEVlTGwwQWdHVlhuM2hVVmRHMmlGSFpleTBVMzJjU0luQStwK21B?=
 =?utf-8?B?UHRDclFEb0hWa2JGT3ZjUTVxZ2hwQndVQ1NXaGNOSTVreHhQU2ZMYTJCSGsr?=
 =?utf-8?B?VTlXcko1M0dpanlrU1lQa094QVV3eGxnUVBtVldjR0FBVVFET0MxQ2FiNnpu?=
 =?utf-8?B?TS90emF0YXhOWDBBMDhMSytMUGFQTVFpcXFPVDBmQS9PT3JvN3N3U3MrWHNV?=
 =?utf-8?Q?CISaFuVv7SA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWExQW9pMTFDSjBMdTNnMmVGcCtnTXN4WTREcFhOTU5qTDRrSzRGNVFFNlla?=
 =?utf-8?B?MXVia3VWNnZ0bkpVWVZNN0NxMmhnS2RDaU5ZLzRUaVJCelh1TE5sckxFbkZ4?=
 =?utf-8?B?ejlrUlg3clk1UDVxRFZDelZsbkxlWFpJejNBeStiWkZoVk5IOXdEQmM3OWZp?=
 =?utf-8?B?MldURGxMRXVvN3RqSitGSG1UOVVtdThldm5JUEhlVlhKdCtVUUNjTFdRWkY4?=
 =?utf-8?B?NUh2Yjlrb29FOEl5QmNLeDNlUmw0R2RXQkw4Y3h5WEFFVnZvUElPS0wxd0o2?=
 =?utf-8?B?SSs1a0g1cG1yTlBUOVd2YVBsclhlaEFXL1BXdUthbTJnYXdqclcwd05ZYkJW?=
 =?utf-8?B?cFIyMDVVcXZweEFwWXplMnZNZ2o4ZEVQSmlkN0NLZmxTd2FacEVSYTBHSVRx?=
 =?utf-8?B?YzZ2Z1NvZkVFUDVUc3k0TjlsYmhLR1dpNDVJdUduamE5RHZocXFaSzRyRWNt?=
 =?utf-8?B?VVl5RUFTZWhQZG1vNDE0SEVSS1E1YjR4Y2NMNFZoS3VVTDFETng3MGFFTWFD?=
 =?utf-8?B?NnRxMy9GU2xzUHNQOGNHaWtLYXB5ZjBmUlRucXlGWmsrcmtsRGtHTWhIU256?=
 =?utf-8?B?MS9ubkQ0eFBFS3hkd053UW0zM0Q4M2YxNHNEZ1lNckxKOFB0dlRmQlI3dHlN?=
 =?utf-8?B?dk9qQ0FHcEJWWFJ0dXlGdVlCM0dGY1M5Y2I1VzQ4U2svNlJWZ3BmWHpuSkdF?=
 =?utf-8?B?cFJna1h0dTVHSCtON1pjMjA3dW0yRGpEYktPeElLV2xEdFV2UHNNQ1ZaUTdU?=
 =?utf-8?B?NGZvdzQrN2x6R2pnWUc5Ykk2VlcyWEZWTSs3dloxdW1rUzZGUTRROFpzeS93?=
 =?utf-8?B?WVJja29xUmdzK1lQUk1RVUNjbktPc1l1NTcxd1pKWlZBNWlqQmRpMGk2T2RM?=
 =?utf-8?B?OTYrc25NWTViVE9ZMkN6SzNUbDk0TXl5YzlEWThFUEp4RXlXNUluQjh2c0hM?=
 =?utf-8?B?UG1GKzcxWExIdERZeE1rUkV6OUh0eWQ4eFRyZCtVS0x1ZTF1dmlqWXlNZzZE?=
 =?utf-8?B?bmJBdStPRE9rcW5FZTNEbTNhRTY0alZHWWtaRWdkRUs2ekNia3J3eGs2QkVI?=
 =?utf-8?B?aHFFSEIzbEpDVlQzNldMTXJkTUczaGtPam9HWFhBR0NhUHU5ajB5Y3REY29P?=
 =?utf-8?B?L1lqSWg2YzFrOG9Fa0FndHFYM2RCY0dHdE03V096S1VkR2duSUp3WXlNMlhR?=
 =?utf-8?B?dmtRZi9MZ3czd3RzNHZvcGZOcFdYNFRRS1BIdG80MWhjNFkwcXF3SXMyMU8x?=
 =?utf-8?B?dG1HWklYRkNpNDJRQlIwZ0M2SnB3YS9mc1pVcjNGN3RZVVhRYytYTVZURGpo?=
 =?utf-8?B?KzFack1sV1h5bGJFNXFhK3lEVDVzK0xLTDFDc2g2WjdpZEVoQUNwcTlHcisr?=
 =?utf-8?B?TkJ2M2lnaSszRkJIMCtyRmpYZmF5Um16Ny9WTHd5NlNkM0VPZGxSblJqMTkw?=
 =?utf-8?B?STBIdGpLZUFrZlhLS2VDNGlXTmlycDc3UHJEaUFENWFyMEpIeGRycDUvRm1Y?=
 =?utf-8?B?UkRjUlhYRHR4MXlscnRxNjFNUDdwc0hzYWQ1ZjFrMzRUYXJzNW8vcjNLN3BY?=
 =?utf-8?B?aEkwLytkMWpTd203YzMwcCtTbmRlMzIrRnlWcU42c0ljTUFuaUQ2a3YwS3BQ?=
 =?utf-8?B?VkVEOGRTTm5kQlNrSkd0UDRLUjRhVWRjRkNLNTEwb3J6blgyZGlwM3pDem12?=
 =?utf-8?B?NnFNOVppQlhUcWs0L2VXNm9BM09acjNBQ3N5MGhIaXdRVDh1a2E3YUtMMmxX?=
 =?utf-8?B?OVYxZVY0QlgzVkdrTlhnUmxCVCswTGpzLzRrT09hejIvbG5UdHY1eWFmam5v?=
 =?utf-8?B?QW5kUUZHYmhhc0EySnhEWURWZUNRYnhQQlVzdHVBS0N3Nkt1eTEraE1yK0tC?=
 =?utf-8?B?M2MrdnFWSCt4Qk1EcTFTelozRnYzdEpqc3FtaERKTTFWU1YxbUlocUF5V0k2?=
 =?utf-8?B?QUNlUVZzRGRzV3Y0S3R0MTlZbzVGNlczdTllckE3UHhqREladXRKTXZlMVAw?=
 =?utf-8?B?ck9zUHdmRzhJbnpsSjlOS2U2OTlxNHJLZWdKaXFyTTJucmQ4cVRDemhIQkV2?=
 =?utf-8?B?b3EwaExXT296MU1haG90eFZBUjRaRUpDWjk5aEFCTVByclZkdTV4d1hFMStv?=
 =?utf-8?Q?Cr2D3txjs8MJNK8pFV/76hX3g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87206d4c-3958-409b-37aa-08dd8e136dbd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 09:33:45.4888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WYW9z60cnAylUDAgJTlezmp0ZyXAZItEQVYm/CeJz8KuBdAIBfBMm+QTwkuIYbr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

On 5/8/25 09:03, Khatri, Sunil wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>=20
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
>=20
> -----Original Message-----
> From: Yadav, Arvind <Arvind.Yadav@amd.com>
> Sent: Thursday, May 8, 2025 11:06 AM
> To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Ale=
xander.Deucher@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Yadav, Arvind <Arvind.Yadav@amd.com>; =
Koenig, Christian <Christian.Koenig@amd.com>; Yadav, Arvind <Arvind.Yadav@a=
md.com>
> Subject: [PATCH v2] drm/amdgpu: Fix NULL dereference in amdgpu_userq_rest=
ore_worker
>=20
> Switch cancel_delayed_work() to cancel_delayed_work_sync() to ensure the =
delayed work has finished executing before proceeding with resource cleanup=
. This prevents a potential use-after-free or NULL dereference if the resum=
e_work is still running during finalization.
>=20
> BUG: kernel NULL pointer dereference, address: 0000000000000140 [  +0.000=
050] #PF: supervisor read access in kernel mode [  +0.000019] #PF: error_co=
de(0x0000) - not-present page [  +0.000021] PGD 0 P4D 0 [  +0.000015] Oops:=
 Oops: 0000 [#1] PREEMPT SMP NOPTI
> [  +0.000021] CPU: 17 UID: 0 PID: 196299 Comm: kworker/17:0 Tainted: G   =
  U             6.14.0-org-staging #1
> [  +0.000032] Tainted: [U]=3DUSER
> [  +0.000015] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELI=
TE/X570 AORUS ELITE, BIOS F39 03/22/2024 [  +0.000029] Workqueue: events am=
dgpu_userq_restore_worker [amdgpu] [  +0.000426] RIP: 0010:drm_exec_lock_ob=
j+0x32/0x210 [drm_exec] [  +0.000025] Code: e5 41 57 41 56 41 55 49 89 f5 4=
1 54 49 89 fc 48 83 ec 08 4c 8b 77 30 4d 85 f6 0f 85 c0 00 00 00 4c 8d 7f 0=
8 48 39 77 38 74 54 <49> 8b bd f8 00 00 00 4c 89 fe 41 f6 04 24 01 75 3c e8=
 08 50 bc e0 [  +0.000046] RSP: 0018:ffffab1b04da3ce8 EFLAGS: 00010297 [  +=
0.000020] RAX: 0000000000000001 RBX: ffff930cc60e4bc0 RCX: 0000000000000000=
 [  +0.000025] RDX: 0000000000000004 RSI: 0000000000000048 RDI: ffffab1b04d=
a3d88 [  +0.000028] RBP: ffffab1b04da3d10 R08: ffff930cc60e4000 R09: 000000=
0000000000 [  +0.000022] R10: ffffab1b04da3d18 R11: 0000000000000001 R12: f=
fffab1b04da3d88 [  +0.000023] R13: 0000000000000048 R14: 0000000000000000 R=
15: ffffab1b04da3d90 [  +0.000023] FS:  0000000000000000(0000) GS:ffff9313d=
ea80000(0000) knlGS:0000000000000000 [  +0.000024] CS:  0010 DS: 0000 ES: 0=
000 CR0: 0000000080050033 [  +0.000021] CR2: 0000000000000140 CR3: 00000001=
8351a000 CR4: 0000000000350ef0 [  +0.000025] Call Trace:
> [  +0.000018]  <TASK>
> [  +0.000015]  ? show_regs+0x69/0x80
> [  +0.000022]  ? __die+0x25/0x70
> [  +0.000019]  ? page_fault_oops+0x15d/0x510 [  +0.000024]  ? do_user_add=
r_fault+0x312/0x690 [  +0.000024]  ? sched_clock_cpu+0x10/0x1a0 [  +0.00002=
8]  ? exc_page_fault+0x78/0x1b0 [  +0.000025]  ? asm_exc_page_fault+0x27/0x=
30 [  +0.000024]  ? drm_exec_lock_obj+0x32/0x210 [drm_exec] [  +0.000024]  =
drm_exec_prepare_obj+0x21/0x60 [drm_exec] [  +0.000021]  amdgpu_vm_lock_pd+=
0x22/0x30 [amdgpu] [  +0.000266]  amdgpu_userq_validate_bos+0x6c/0x320 [amd=
gpu] [  +0.000333]  amdgpu_userq_restore_worker+0x4a/0x120 [amdgpu] [  +0.0=
00316]  process_one_work+0x189/0x3c0 [  +0.000021]  worker_thread+0x2a4/0x3=
b0 [  +0.000022]  kthread+0x109/0x220 [  +0.000018]  ? __pfx_worker_thread+=
0x10/0x10 [  +0.000779]  ? _raw_spin_unlock_irq+0x1f/0x40 [  +0.000560]  ? =
__pfx_kthread+0x10/0x10 [  +0.000543]  ret_from_fork+0x3c/0x60 [  +0.000507=
]  ? __pfx_kthread+0x10/0x10 [  +0.000515]  ret_from_fork_asm+0x1a/0x30 [  =
+0.000515]  </TASK>
>=20
> v2: Replace cancel_delayed_work() to cancel_delayed_work_sync()
>     in amdgpu_userq_destroy() and amdgpu_userq_evict().
>=20
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index afbe01149ed3..c7c927db24ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -300,7 +300,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue=
_id)
>         struct amdgpu_usermode_queue *queue;
>         int r =3D 0;
>=20
> -       cancel_delayed_work(&uq_mgr->resume_work);
> +       cancel_delayed_work_sync(&uq_mgr->resume_work);
>         mutex_lock(&uq_mgr->userq_mutex);
>=20
>         queue =3D amdgpu_userq_find(uq_mgr, queue_id); @@ -745,7 +745,7 @=
@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
>         amdgpu_eviction_fence_signal(evf_mgr, ev_fence);
>=20
>         if (evf_mgr->fd_closing) {
> -               cancel_delayed_work(&uq_mgr->resume_work);
> +               cancel_delayed_work_sync(&uq_mgr->resume_work);
>                 return;
>         }
>=20
> @@ -774,7 +774,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *u=
serq_mgr)
>         struct amdgpu_userq_mgr *uqm, *tmp;
>         uint32_t queue_id;
>=20
> -       cancel_delayed_work(&userq_mgr->resume_work);
> +       cancel_delayed_work_sync(&userq_mgr->resume_work);
>=20
>         mutex_lock(&userq_mgr->userq_mutex);
>         idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
> --
> 2.34.1
>=20


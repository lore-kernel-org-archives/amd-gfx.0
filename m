Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB6BEDF173
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Feb 2026 15:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6386910E2F5;
	Fri, 13 Feb 2026 15:59:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mfdlC7OH";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 114E210E2F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Feb 2026 15:59:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFcr+dn8gEwLBE47ygIXD7YrE4CbuiKGSWu7qwhLjipuSLGa7QOlAm4fcroq+919NV9+FTvwBYqA+woEHn3evEbF9YF/LqoonalEd8v865wGKmBMkL2RzqblLdRyU4K0pSzkJ15lunY33fZd707BbVqz4Bcln7TJDehS8tug/YTurVmdKwyIlP+8OADqZsnMr+DWWJtH2Q4ghYtxvZoe48aRbZ+fj5OFDEKzxePFjPOqr5y0EQEImjWUotgApsVK3X7siLiAZpPBcMVicjs+aOecRL5GYIi3KaI4SsYUDmJoq7kUIia9xkutdqya4XpNJtXYGdEA83Tpp8SLf0cRuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IszUSx8IngOgJ8AV3ghsPdfsVWv1yFtndSYA1V64VDY=;
 b=ULABSxxckqiZUV9n6/yFvEgCjccTcHZRGT5nQLWzAiPlHmtw2JQYbG0P4ULPE198kMCHGn2zW9ENAQ9y8Ws7o4V8JD9QQ0xrdAmMJlpPb2VWgK2PP6Xx1hqPbBFbJYmKmhTBfzQSpXYLFPpbi/Q7O64gKQ0m5afwdC5G52kyZJPgvuVyNUu8MALmCpn9vdgnZ+ibrea1xcELiOitC1Ux8yuyRBmrgk7v30OBqwoKWetQCjMQAPCRxwYKOQDpla+DABWkS/QtiBzHTyfadwrVsSKAgvGViYGy9XqKzfgDNFpsg+eGC+1371d5k+aBDVniMSRyBUiqMUJKNSQ/pyoZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IszUSx8IngOgJ8AV3ghsPdfsVWv1yFtndSYA1V64VDY=;
 b=mfdlC7OH7sWotcuHFVYxxeHiVnQ1oA/iAXG0SR37RPheceAwtBpwH9N9QjutuM8NKGHOeCQePtIpbd9L9jyEVzCNkv1lTzCx+GxwV4KDzXo1Y2mMPFD7TIESUr+lk+OLSFwLGB/JuUYGmAgf9S1RYbEzzn0ywBfALno3DT2JVLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 15:58:55 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%6]) with mapi id 15.20.9611.013; Fri, 13 Feb 2026
 15:58:55 +0000
Message-ID: <cf04d6f0-641f-4084-a74d-9128f58c2c83@amd.com>
Date: Fri, 13 Feb 2026 10:58:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Disable MQD queue priority
To: Andrew Martin <andrew.martin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: jay.cornwall@amd.com, joseph.greathouse@amd.com
References: <20260212194256.33118-1-andrew.martin@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260212194256.33118-1-andrew.martin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYXPR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:930:d3::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW6PR12MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b2ff225-cf0f-4f96-e27e-08de6b18ca5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkJ1eGtnb3oxVmZ1MHN4ZHVZWWg5eENkUzhWQm56THNhT1Y2QTBzOS8zL0ZC?=
 =?utf-8?B?U0llYlMrWC9VZmR5ZENXekRVZ0pYc3pCWTBKQytPbGxidnozRGlnSFVjZHNP?=
 =?utf-8?B?cG8rSS9XajVPS3R3cEVxVmoycC9WY0VpeU5ZSEdSdDhsVlRFaVBwWkdXa09x?=
 =?utf-8?B?K0k5bDI1RHlCc3lSdmpKc2JmTUEzOG4za0dxWjl5RksvQU9reFdzZFQ4eUVE?=
 =?utf-8?B?b05BK3FlMWhhU3BLeC8yS1RuUHhnU1VYTENFekxGdTd3aVFpV0FyS0lXUUcz?=
 =?utf-8?B?RmZYNkVkaStESDFiWDFkNE5rWUZGUWVqemZnakJpeUpNa2szejAyVW5TbUs1?=
 =?utf-8?B?VUtwa2dud2Z6Qi90YnY5Wk5MK1RQYmk2bVNweTNESktuOUwvckFKSXhwak9y?=
 =?utf-8?B?ektGdFY1QjIrdlNQTEsvOUhBUjNwQjVDcytFSXU2SHRVNThQcXNLVjdPZHEw?=
 =?utf-8?B?UjMycmNpVUtTOE1RRTdTc0x4amVObDgzZG9MblNrK2tWamVYamVtWDNZaysv?=
 =?utf-8?B?YnV5WmlyME1JYXNFZ3VyOVZKSC92a3BkTEFEZzVzbjFFN0U4V1RoZzZ0dHMx?=
 =?utf-8?B?VmJYQmxJUkJTZWxHbE1zMUV2bnJrR2ZFTjYrUTZzeXF2b1FOSXJSdkJpUFlU?=
 =?utf-8?B?NXlIZ3NyeEVweWJJNVdoTGlydmllM1lNNGpGb281aklLSTdEUGEwS2ZWNmRy?=
 =?utf-8?B?MkloOHJSZytySHg4clFQRkFMY250dHdzS0thOHN2aHRTdUlRaTdWRmFUYkY5?=
 =?utf-8?B?OHBWQjluZ0c4dEZNOXhjNHdKdFFmQXlsbXIyaEwxMHgrRm9FdCs3TjZneEky?=
 =?utf-8?B?bXJESDJnWEt6U3VacURUN0ZKcElyZnVldkRIZW9rVVJ6K2t3dUlvMUZVWHVk?=
 =?utf-8?B?RW95a00zd1MreDRock45YklOd01PQi9XZTk2M3c5aXYzMGhGcW96YnJxMlFE?=
 =?utf-8?B?YVZ6dS9sdUQzeUx5QnZ2MEszN0ZnV2tTUVVxOVZ6c3JkUFV2b1hkMDcvSVMz?=
 =?utf-8?B?d1ZFMWtrTDZkYW1CdStLcDArNWVobjRpYkxEQ2duMkZ0eEpNalRBbmowOEVJ?=
 =?utf-8?B?RjdKTkFlL2JUUnA3RVJWZTNBWjlQb2VEYW4xYWE5cUtHbllCS0FYV2tRSFA4?=
 =?utf-8?B?Rk1Md2NzNC9SWlFTMkpXTEVwaUVRbDROSk0vVjRFV0xxeFdncDkzeG1VV0Qr?=
 =?utf-8?B?TWxCTTZwTkFLV2JTZ3YwOTd1U3lVejNjOWNTb1NtTGgveWRRNitwWHRycUFR?=
 =?utf-8?B?VWxLWXBaTGhRUStPd01IWlAvTE1XTVVHbmpuMFd1Q3dhZ25CQVVLZFMvY0hi?=
 =?utf-8?B?b1NKcFlDbkEydFVZOFhaTEg0VVBWSlFTNnZZQXJBaDIzRExYUTBtVVhHb1Va?=
 =?utf-8?B?ZlhzMSszcjlDT2hRd0c0bUNFd0w2aCtvZkZNMmJQWndLTGtGeE0zZWloTHB3?=
 =?utf-8?B?bWdxdWluOUxldHVQT1VBdDFHL3RiWS9oYWdKdmhqaWhVTkRLZDlyMGM4VXVX?=
 =?utf-8?B?aVdtTWZxVnpkZnVOQmlKczJWck14YWVWc3ljMzAyRlRLQm9wNW14K01mcGRL?=
 =?utf-8?B?QXZKYjdRS3dtQ3c4U2JYVGwvVjZsOGJPWnRUN2o5TTJMMzZXLy93OXFBOWZr?=
 =?utf-8?B?WGhaQm02UHdZWGlGdU1zOGNleWhNWHBMc3VOQ3hlTytkbjNLRCsvb1pHRUdj?=
 =?utf-8?B?ZnZxNG1TcndRdFVoUEUvVmpNL0FldW5xQnMxSUZ4b3g5alVqRFlaNGo3L3F2?=
 =?utf-8?B?aGVoRHZnakFWd092UStWS2NtU1JpK0htU29vRVNOcXVMOU5qaHdSbjBzbGw3?=
 =?utf-8?B?aG5LbW1FTHJBUVI2Zlg4TTFVbVJ2aVprbndCTjJnTEhaMzZPeVhRM0VwRFRx?=
 =?utf-8?B?M1JUbUV1bm91Q25KblRPWkdaS3ZBUEg5TXhJejNoOUg2WTdHUW83ZHdIUUFq?=
 =?utf-8?B?UkJCNld2QTZLMnVVcHlxeUJIdHRLcGJadjZOM0h6bGMwT0YxcW5kOXprTEJP?=
 =?utf-8?B?SlFpMTJSMzhQMkJVWXl1QXk4NFkvOERXRmxTZGJxTklKdWdjR3h4cnpqb0Z5?=
 =?utf-8?B?bURPdWQ0azlTWi9Fb2RBeU1OUVdmTXdWUlpoNHUrZmhQUHdFelNmRmlXMm1r?=
 =?utf-8?Q?NkpE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWtlVElYQ0xTSzBMcFRoV25vWUVjWEdJbWIwVGRnNEJOY1FQNGlZcmtHTmVT?=
 =?utf-8?B?cXJIbkExdzhHdGlnUEVuRVRsWlY0dmFsdWtVTFpoeUg1M0VFWDdDU0wwWE1E?=
 =?utf-8?B?UEJ2NU1aT0FWek94bE1oMmd0MkhjeFp3SFRLTGhEZkJmTVBWUTJRd2lNcTho?=
 =?utf-8?B?ZkVJQ3M2LzB6a1RGNHNpNi9oMFRpSmxSdkdDSm1zbTVhTnhWbVdtOFU3SXZQ?=
 =?utf-8?B?RE5Ha3UvTEdiazlHQVY1Y2RCZnphaThWcCtITmhNaDRWcWRDSml5eUE4V3l3?=
 =?utf-8?B?UURhNUY2ZG5XS0Vmd21keHRtb2VCOVJCK0RpSzM0N2tSdGQ3V1hZV1NXWm9J?=
 =?utf-8?B?TjR0S010Z0p0bFNwaXRHOXBWY3BpbFdQbktOUk1TQ2t4ekliZ04wb3IyRzMw?=
 =?utf-8?B?RjZnNFFTMzZZUHRSUE5GTkZOMWNEanFxdDFmK0xTeXdvZXNsL3lFMWpEUitK?=
 =?utf-8?B?MG44STdRN3Frc1p5UWIrV1hoaTB6TnFYa3lGaDdyd3hQS0E3K0pjMi91VGp1?=
 =?utf-8?B?UGEvV09hQkZmQjhOQ3QxVkRBajZrMTY1b3pIOHYzUDlEcWxvcjlRL0QrclJG?=
 =?utf-8?B?RklJUUdyaGRzL2c0N1RQcndobWUzTDBiUE1IdXIwYVZUeStjajV4SWNGY2V4?=
 =?utf-8?B?UkE2NW43Vm0weFRhNVRJaFRneTlRVnVpYWpGbmRrNkloZnlIckdoTERqL1FY?=
 =?utf-8?B?ejF2cTQzamJ0dC9IcTdxZTBhNDdWOUc1dUlVdWY4Wmk5bVloNUViWXR4SU5W?=
 =?utf-8?B?MGloaWlZYVkwUXRES0tldVNRRVdUUlk5MmR4SjhMVU1wWlVzVEtwN1dpZ3p1?=
 =?utf-8?B?M1lHbXRCa2c5MFBVTGl5eXdZeitnMkhsSFhONEJuM3dTNEJySHBlbXJPR1pI?=
 =?utf-8?B?dXR1b0NnZTAxZFV6ek8xM2dJNlBEdXFSN283SnpDSmlyclg2TnVSa3hmMWFp?=
 =?utf-8?B?eUM1WUtOakl2Z0ZqOW1sZTllRlNITXg4ODUvRkF0Zms4L25lV2x2TmtLQTRx?=
 =?utf-8?B?N09ndlBlOXJ2bEpCdGp0M29ESnArajE4ajBXa2hHOURmdjF4MWRCdTJWMkND?=
 =?utf-8?B?L1ZLOFlCQjkwSW5sMHhVWGZNb3ZpVWQ2Uk1tNExSaEhiQnhwbDdCOGhDT3N4?=
 =?utf-8?B?WURzekdmRHN1aDR3UU9TeEpSZWt4QTllTmZVMjUxdmRqZEN3bGlibHdUSUR2?=
 =?utf-8?B?aDN5YXowTzluY0N0Qi9sN0dIelJPem1IaGk2MGlDNmJvOHg1Q1F0TytMYUJP?=
 =?utf-8?B?SzgveXhSZmRPQ0NseVBOMWFpNjFtbnhoaGZRcGp2UEI3Q1NSaHZYMWlhdGhy?=
 =?utf-8?B?WStjVW9CVkJSQmpuazVXeEhlVkJxbytoSWFUc1NLMlBaV1M4ME92MWhuc1lN?=
 =?utf-8?B?RnNkajFmdjZnK1k2bmRJTzNIK3N0SUZkNFpzVm85SFQ2UGU2TkhqcWY1UU5R?=
 =?utf-8?B?dUdNd0cxOTBmUkY1REYwaVJtalNxUXJSY3kxOSt3K2ZCTkh1N09WVTliMmQ2?=
 =?utf-8?B?Ni9Xb3EycmNuSXpJaHZTMHdoWjZxNHJiR1U5YWZ0VC9IRG14V2Y5a3hKZ3dV?=
 =?utf-8?B?NEVwT3hGbEY3TnBQejV3QkxmZ0xDcGFUNjgvTjNCaUhMemNYY0ZSTzNpTHVJ?=
 =?utf-8?B?ZlgwMFh1RlM4cUs5UEtEczVMbnlSRStwZWY2OVBRbXVibHZVckFjZnBFbndt?=
 =?utf-8?B?dEdCcXd3Snd2THIxUU1ndWVyMkpUNW1teFMrQnd6eDROdnNpRkRnL1VJV1lz?=
 =?utf-8?B?ejhOSy9TckFtWkhZV2xTU3cvd1psRjdwOXlNVXQzZnJDVFVTYjNweDZjdjlE?=
 =?utf-8?B?b0EybTlKSWZlWHdDWmtzVVd3aWlxSDJUNjZVdWdnclljTkx0ZlZ4MEJIMG9a?=
 =?utf-8?B?WHJObExaSnRJOWEycjZSVXhDWFBuR3VGaUN6MmxkckJtTU5jd2NsTWhHWCt2?=
 =?utf-8?B?em1rSHRRdTY2MCs0V2hyNWh0Zm9TY05HejJOTkFDcFFjRjN4ajVtSytaMEs0?=
 =?utf-8?B?VlBSNFdKVXlQWkdocHByZnVSL3lYcTBOOEtaNjliSVk1am8wOTRxdmpBdktv?=
 =?utf-8?B?aVlEWGVPMWplYm9RNW9LM3FVSXB2dHF1TEljRFlzNERxUCtUUGcxNWdhYnA2?=
 =?utf-8?B?Y1VhWndIOHc3dFVFdVNlK0tUQncxMER2ZnE2QlNEbnhqaHpNYlMxc09VWXJY?=
 =?utf-8?B?Uit5YnNQVHk5TnRRdFlwTHZPdTZLOStHV25SRG1aVFhzUHh1REhIVWl1V1Vt?=
 =?utf-8?B?UWtLVXJqelFqVFBHYjFsK09yNlNVVUlkUktidDBjZklJTzJ0OGY5L2pRL1VQ?=
 =?utf-8?B?TDFMWFM4d250c1ZOb0YrUmJETDlJNjRVd0FCajNPRmFpakR0ekczQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2ff225-cf0f-4f96-e27e-08de6b18ca5c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 15:58:55.4182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILjkr26sPIPkcBwClqFAyAuYyym+85VbPGF4qPO8AZMq3spgPaILQoywv60IaWEpkPn2lwuMtlsxR03iuJtJ3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7070
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


On 2026-02-12 14:42, Andrew Martin wrote:
> This solves a priority inversion issue, caused by the language
> runtime making high-priority queues wait for activity on
> lower-priority queues.
>
> Signed-off-by: Andrew Martin <andrew.martin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c   | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    | 2 +-
>   7 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> index 90ac3a30e81d..76483d91af98 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> @@ -70,7 +70,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
>   static void set_priority(struct cik_mqd *m, struct queue_properties *q)
>   {
>   	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
> -	m->cp_hqd_queue_priority = q->priority;
> +	/* m->cp_hqd_queue_priority = q->priority; */

Please remove the commented out lines here and in the other files. With 
that fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>   }
>   
>   static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index 97055f808d4a..0186b3de67c0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -70,7 +70,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
>   static void set_priority(struct v10_compute_mqd *m, struct queue_properties *q)
>   {
>   	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
> -	m->cp_hqd_queue_priority = q->priority;
> +	/* m->cp_hqd_queue_priority = q->priority; */
>   }
>   
>   static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index 7e5a7ab6d0c0..c9e397366782 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -96,7 +96,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
>   static void set_priority(struct v11_compute_mqd *m, struct queue_properties *q)
>   {
>   	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
> -	m->cp_hqd_queue_priority = q->priority;
> +	/* m->cp_hqd_queue_priority = q->priority; */
>   }
>   
>   static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> index a51f217329db..3bbc2648f51d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> @@ -77,7 +77,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
>   static void set_priority(struct v12_compute_mqd *m, struct queue_properties *q)
>   {
>   	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
> -	m->cp_hqd_queue_priority = q->priority;
> +	/* m->cp_hqd_queue_priority = q->priority; */
>   }
>   
>   static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> index d0776ba2cc99..0d6b601962eb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> @@ -131,7 +131,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
>   static void set_priority(struct v12_1_compute_mqd *m, struct queue_properties *q)
>   {
>   	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
> -	m->cp_hqd_queue_priority = q->priority;
> +	/* m->cp_hqd_queue_priority = q->priority; */
>   }
>   
>   static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index dcf4bbfa641b..bc4ceba35908 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -106,7 +106,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
>   static void set_priority(struct v9_mqd *m, struct queue_properties *q)
>   {
>   	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
> -	m->cp_hqd_queue_priority = q->priority;
> +	/* m->cp_hqd_queue_priority = q->priority; */
>   }
>   
>   static bool mqd_on_vram(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> index 09483f0862d4..e63ef6442b35 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> @@ -73,7 +73,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
>   static void set_priority(struct vi_mqd *m, struct queue_properties *q)
>   {
>   	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
> -	m->cp_hqd_queue_priority = q->priority;
> +	/* m->cp_hqd_queue_priority = q->priority; */
>   }
>   
>   static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,

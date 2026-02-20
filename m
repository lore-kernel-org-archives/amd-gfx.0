Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358ECC54FD2
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 13:31:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B281110E02C;
	Fri, 20 Feb 2026 13:31:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cHUBqcPO";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013033.outbound.protection.outlook.com
 [40.93.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A4B10E02C
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 13:31:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8pOdrv2Agf06w+j62YPB7CApFzVtbohTB7fI1MNAw8IARj3qczXdDROjdzcN786d6FZD1Yf+RtEyWdRZUjvu51xd1CQJmWTfWjJ+SBVAsfsTCgSJbQbj+aaBVekAieLUrVFLDflF0W+IiEMYylZTRGoM1VHORaIreltnWM4ErXo7lMb17CD74vEcegZ0P45z8Mgy57DwmSBeyMPeY+O340SENPVC0CQRiZ9Gxp3NorkGNxvqqeigfHh3FpZI+J2vhfTMCqQPpT1+IcKDVW4McEVkvu65L/ZIgxsuN3Q6QYK741TX3gpRp//GGVbxmUjI0gm7PM9jO3i4nMEmr9c6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCgw8KSl00Zl4NgmJgqXZwOIqS6zfEOAjOHr/Efiw+0=;
 b=PXPbxjuXSNOacX/895R0K2Yrr69Ujp7kv+eYxRf9hbu9eTzD4VZtuleq1UN5iZs9TUCG1+3JUyJLatwURwJGsATxlmF+jNxDDDfzm55SO+JAfJabULUECaISj4G5y6P4xkUHrSk4KHV4Ul7YDEDIrBGSfqG+2pxfhp1PeLesnQlQwkz2QWJvhiAfmhkAiOpZY70EP6gea08KIe/BeELrBOon/dC3HmsAZ1NZ10EMxbeEkFK/gEsPZE8IIaJd9CeRLjLjE8dfCyWy2UThFDneSIieu9qwf1itfdl1TfAbMcV+vgqRoO3bNXUCRi/IqpZXNEhTwtGDmG+0O7yC/x9iMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCgw8KSl00Zl4NgmJgqXZwOIqS6zfEOAjOHr/Efiw+0=;
 b=cHUBqcPOAJMQXWWVzaWefYZPgU1GWmmPxB6N7yENDX/mJmusWusYog5rjnxj8VVDEA+2vYqE7ulffmKKJjMK3+CZdlXNfa4/NZAUGDWwCrWn2w37QwLTsr6JoMDXv8r7YtWklCXmNwIjMPpBoaTlifeWZ+UBPVfr6Mzbsi3Qtms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ0PR12MB6734.namprd12.prod.outlook.com (2603:10b6:a03:478::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 13:31:42 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 13:31:42 +0000
Message-ID: <92caea0a-470a-4b76-b2b2-23f5af0a4d6b@amd.com>
Date: Fri, 20 Feb 2026 19:01:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] drm/amdgpu/userq: Use memdup_array_user in
 amdgpu_userq_wait_ioctl
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com
References: <20251205134035.91551-1-tvrtko.ursulin@igalia.com>
 <20251205134035.91551-7-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20251205134035.91551-7-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0217.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::15) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ0PR12MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: b893583d-dee8-4a5a-a4d3-08de70846242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0hUOW9meG1ySU1oOHVkYzFMR1VvRk5rQWk3TzAyT0dBSWJWTkx4MWszcHVL?=
 =?utf-8?B?MVVSZ1hieGc0RWViWUV3NDhXMkx5NWltNmJ5Y3dFTVlwQnJ6d1dnL3dtbVRm?=
 =?utf-8?B?WkVFR2hjMEErOU5KNWR6RnlMQ09NUm42L1hhU2REeUd2dGhoRGxKMEk5Nmo0?=
 =?utf-8?B?UlgyQzBwMkJiWXFyQ3dpb1Z5d0NOL2ZQS1ZXL05uYWsycncwK2IvV1JDZVNG?=
 =?utf-8?B?Rno5d2NmV3BMd2N5MlBxNXN6WWNkWmNyOHprd09JcUJHNWxvNGZvUm1lSWx5?=
 =?utf-8?B?QkRmNmZ2OGk1SUxHeEg0c2xRQlVXWVgzVko4YzhSQ2tic2RkQ2ZSZG9sK2xa?=
 =?utf-8?B?RDRJLzJDalBnMERySElVeURmczRUNTBTVEovSGQxMDlobFJoU0lMTVRJZkpK?=
 =?utf-8?B?emVqRy9NNkZnbDhqSlVmSG1KTVVyL1E1aHVFOUtwRUxzQUh5Um4rS1o5WGxk?=
 =?utf-8?B?czVJU3FKVWpjNUJ5eUt1UmFIYmo4SjZ0aWtTbVJwWWVLdmtpRi8yZVJJT1pt?=
 =?utf-8?B?eDF1RFloeHdPSDhGWUJuSVNvUTlNcHlsYWFmNTFldlBQTk9sQXprTkNjN1Br?=
 =?utf-8?B?WUl1MWRvZTRkQU5GYldiVGJpM1FPOVo4b0VMVWdZSWxVYk4wdUdiUUprMDNZ?=
 =?utf-8?B?b1VVb2lPSFF2d21GeGRoMXNmaDdxelhzZXg5aEFnK2YyVTdxS2daSktXSEds?=
 =?utf-8?B?L1pFaTNkSmF6ZWduY0RpalRyNjJ1RUdpSHIwZE9FVDR5RWtOUWY3dVgwZE5K?=
 =?utf-8?B?MkdtcmszZzRNVTI3RUFqK2tCZzRFamhLcjZIU1RkNFF4bVNyNWpwU3I3ZnFk?=
 =?utf-8?B?M0duOGJjUWRhT29yZTlrNGJ4ZUkvZVJrWUw5YWZGVUdQVTd0YXdTeGpXUUhF?=
 =?utf-8?B?bWpDdCtOaVNPNUxudDJ2U0xOeEwwTVZuNFJiNUhGTW83dkFGLy9zSkZvWmU1?=
 =?utf-8?B?SERsQXAzN0tia3pnWXhrN3Ztd2twMVZMV0dZOGd5cnB2dWltZ2RKdllqRUov?=
 =?utf-8?B?SmZHUmltakxmNXp4ZW5YOUJjcnJIcmtvamk3UjVHTUhScUo3M2wybjVVVE11?=
 =?utf-8?B?ZVZPVUxrNXBvRlE5d0hBK0JLdWJzMmszbEh3SDdpdTI5eUluTDZaenQ2NUhF?=
 =?utf-8?B?clZFKzlsdEYxRGFZOFZxV0hqOEhDb2xmak0xQ1pWcERkTE94OXVCY0xlcVhj?=
 =?utf-8?B?RlRHM09VSmRiUDZEdlNpdGVPajdCejczYlprclBHNFBETzNsWjRNN09TbWNV?=
 =?utf-8?B?QnBjNWtjOW1oTnM1KzhMeGxrUHA1WnVCYUNKbDd1REpIVW5vR3h5azhZS3hy?=
 =?utf-8?B?SnJJQitkZlF4L3lTUVBUK2x6OVU1cS9VY0xqSkhrSzZNSmROUC9PU1I3MFhH?=
 =?utf-8?B?NGZHdXFzQU16eVRBN21TOGcrd01JVVpVUVZtRFRGV3I4VWJOR09VZzk3ck5X?=
 =?utf-8?B?U2lGbVhMTzRPSzNrc2tSckV4cW9LN29ISHlDUzJXVkNOTW5EdmZTQTdocXpz?=
 =?utf-8?B?SlJRRWczOU9QQTRReEY5ODdLRWZTL0ZHeUpMN0djNGl1dk5kTndIY3d4RWh0?=
 =?utf-8?B?VmpkOGhjVGxiUktXakZiQkt0eXhRMWoycGVCb2o3bVhqc1BJa0V6V05DZVNQ?=
 =?utf-8?B?TDFXZW9lbHpnaW1KQnVhaUQrbGJRMExzS042Vi9SNHlxMHlPUkwvOUJVNTRU?=
 =?utf-8?B?bHhvNVF4ZDg2RmFoQ2JuakE5K2tETzRWcmIyYVpNdEFsdEhCNmhuVGwzaS9M?=
 =?utf-8?B?RHFVWDZiUXR4eStxUTJIcTdhcWdicnhqaldqUzRWS0ozWmh2SnpDSW5pQlVi?=
 =?utf-8?B?UU95OEo2THN0M2NJZzc5S205MG0rQ2ZVWHc0TlI4QVRmcXFCelpJQ0xHZzVx?=
 =?utf-8?B?TWljZTdaZkxBVmNpSDhHL1dLR3VrQyt1KzdhWVV2UVBqYkpEOWd4UWwxSmpR?=
 =?utf-8?B?ZVRGUytFdzRzQ1dQRkNOOUx1cDF2d2FvVkFHSW05Q1V1NEgyY1BXcFRROG91?=
 =?utf-8?B?ZjVPTkV3Qy9NbUI5UDVPSjZXUkhtTzhJdVgwU1BCNnAzNEF3cFAvM0N4WjZa?=
 =?utf-8?B?MThSbktXN0lkTitLcnU2dzNCNDc0QU9rME9RSlF0MHlyd3FwTFJIall6Znly?=
 =?utf-8?Q?jCOA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eC9KTXVZV05XZzlVelNNa0hXVXBpMXhVa1ZhQ2t0c1FXY09Bb2RxT0FOOCtK?=
 =?utf-8?B?b2hpTkVQemNTNTNQZU1SalVNZk1VQlFYU3VjUnVUVTVJenUvLzRBRXNkY29w?=
 =?utf-8?B?S2hkeitmd2c2MW85ajM4V0RVYjhVSG1YOC9seVlEQ1dsMi9Ycm9aTjd0S0NB?=
 =?utf-8?B?aGZ5UXJkZWlGb3pPWFlwMmNIQ2pZTWRPblBrbWRFbVgvRzd3SE9uY1ZDZHFh?=
 =?utf-8?B?aXNPaUJkdGdRTjB3cjNCMmMxajZGYVlGRmx2L3NYZCtWWGhNcnZGSnAybVE4?=
 =?utf-8?B?bTdJc1Q2cGV6cmkxYUpWdXNHUU1adm5raXJCdkJkb0s4WVhlRWdGdm0zNzBM?=
 =?utf-8?B?WWZvd3BQdjhlVUpXaUczOUNzMEM0MkRlaDExTmNuZUYraWlxK2p4eTJ0aE5B?=
 =?utf-8?B?YkV0OTFSVlFtUkh0YU5iSElrUnU3MFhTVGZOMEdST2V0NXhFUWxQTjVGUlFk?=
 =?utf-8?B?T0RBOFFHVG9qZk9NcHZML0lVTENDS1FSUjR3MHR3YXpPSWUwUFgrNzRpNTJk?=
 =?utf-8?B?bGpnRUlpOW9KZ1dIcWIrUEhvK1JlSnRWM0grYWxSVDN0djlpY05RaFZsZGxK?=
 =?utf-8?B?RWxxdHVrbVM3bW1aeGxrOTdMNUY4S0FETWVyVHlyZis5MGszYkR3b3phdEJv?=
 =?utf-8?B?WjNVTDg0SjNYT2JpQ1JVY25ySFhlMHhvNWM1dHY5aEIrZyt2MGZmbkRuR1ZC?=
 =?utf-8?B?eDdwYW5ydGZValNORFgvVDBiMnhmTHdqVllwcDV1dzdBUXk4S20wUlo5eTRR?=
 =?utf-8?B?aVV0K1N0YmFrSnN4YVVSYnR5OXZuQ01HUmt4aVJlMEdVQWtvNk10ekZtRWdx?=
 =?utf-8?B?NEVZTE9RL1JSYm5uNGEzRVU2S0JVSXdpMnNVUVE3RnhPTlZRTzhBTlFDRDE2?=
 =?utf-8?B?Rll1b3g1M1VvMHduMHVpTmZHZXI3eEZIY3BTMUNSUzRQbDdON1BQRGV1MVRY?=
 =?utf-8?B?U3IvRkllVzJiZUhOU0pnUEVjM3hjeitEMWFIVFFweDJmYVJHTWtaUEZiZzF6?=
 =?utf-8?B?elp6Wi9pRzRCWG54ZG9hbGI4TG9CVjFGLytSSnhIU1VaUjZkek10WnBQZEE4?=
 =?utf-8?B?MzBuRXoyODR2akQwYk5YMDltNm80VlhheVNMNUtFR3A1WFlFZkFvMjZ2d1du?=
 =?utf-8?B?bDV2cWEyVlNWeXZvdTdLSm1STmM0eWhZRG9zdjFyMjdxNEJXWi9Pc2VTK0sz?=
 =?utf-8?B?UGFDc05Od1pTaWw5MldybTZKc2d1bWpvTkh5c21aMUtsUzhxRnI3YU5nbjh1?=
 =?utf-8?B?dlFZOFZQV0VUUnp1c3FDd09IaXFMMkdzckFqTmZmL1V4Vks1d2JVVGRKMkNM?=
 =?utf-8?B?QTZGK2JHZlhDeDlVT0IyTHlXckZ2dFRqb3lpZFhHbmN4bjdhY216QnFURkhl?=
 =?utf-8?B?cGRzbEozaWpGa2k0M1VyTmxaUUJZMmZOb2lLQTUrQ1Y2QUNnUG8wcDk1L0Jr?=
 =?utf-8?B?K0FoVnFUZk9iS3VVdUEzTmk1eHJYTGROcDU5UkFscmQzclg2eXpEUUpyM2Np?=
 =?utf-8?B?K3EvZkFva1hXeWFZM3hQR0lFNlYveXNteGhuSDl4ZjNTQU9RV1hXOGFwVzhB?=
 =?utf-8?B?azVoT1ZzZWkweGd2OHM1emxmcUY3UDBuaUVNOFcrR3JnL2Vsd3FOODdxUFg2?=
 =?utf-8?B?YjFuNUxsZkxzZGluL3FvY2lseE14aVMreGJxN2MzMjZZUnlGMmM0M2tVeVZa?=
 =?utf-8?B?OHBRNld0blExdlZ0K3R0aHo5SCtvS001Nk5WRVVDcFNaekFBWlBXZlZreU5s?=
 =?utf-8?B?L09MRkNrYlRpN29ieXhKY0tzQWUveEtaSExKWXB1WDM3b1FXSVN5MUxUZFVR?=
 =?utf-8?B?V0tvQk9xSTRNWTBsMHpmZVFSRE1OemFIN1g5VkxheVlQZDFmQTY1VHlFQ3ZS?=
 =?utf-8?B?U3hoTTdhNndlNUlVcjA1VE9MMFNFeGdpV3Exdmt2OUl6cDR3WHBIUmpmREVX?=
 =?utf-8?B?UWNQblEyMFdUTWVrRnZKV1FObGQvYUJtT2dMWnN6cVIyUmN5cUtBb1FwMXdo?=
 =?utf-8?B?d3lzRURnN1QzY1loclVSZ2pQUERJaENERnMzS0tZbmZxY0lKa0VoM2hJNkFB?=
 =?utf-8?B?STRYaGlrMFNzQ3BqQUZrODkyUXBQYUJoUW9oMXFod1QrWUxVSEdXQzRhZStI?=
 =?utf-8?B?eDlwRDB2OEQydW05TENSL21QUXM1cjM3TEsrU1g0Q09YYzh5ZlhpRmZUQXhQ?=
 =?utf-8?B?cFhWRHVpNVY1NHN4VzhGWTBhKzBZWnM2QlA2NlJ5b3N3Qm9LMzlrNjJlVlhx?=
 =?utf-8?B?bEp2ZVlGQjk0U3Q5ak9oVkUyYSswYnU5YmZzeUlFTEs5dDN1djBtenUzVTVh?=
 =?utf-8?B?ZXlxcTMyT2lhOWpSY1F6TDVzQ1VJL3haZU0yTWxjcWFIbDRUT25JZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b893583d-dee8-4a5a-a4d3-08de70846242
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 13:31:42.3591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+Uf/DhWzI2LOknMNxpfz7taZHI5Ec6+e8LGWgbves1hMN/X5w1tab4LuskYaFS3pZUj40L6nx5nY63SORvmwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734
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

Please make sure the changes are made for all memdup_user
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 05-12-2025 07:10 pm, Tvrtko Ursulin wrote:
> Use the existing helper instead of multiplying the size.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 7aa26e88c8ec..f979e896c714 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -618,21 +618,21 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   	int r, i, cnt;
>   
>   	num_syncobj = wait_info->num_syncobj_handles;
> -	syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles),
> -				      size_mul(sizeof(u32), num_syncobj));
> +	syncobj_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_handles),
> +					    num_syncobj, sizeof(u32));
>   	if (IS_ERR(syncobj_handles))
>   		return PTR_ERR(syncobj_handles);
>   
>   	num_points = wait_info->num_syncobj_timeline_handles;
> -	timeline_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
> -				       sizeof(u32) * num_points);
> +	timeline_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
> +					     num_points, sizeof(u32));
>   	if (IS_ERR(timeline_handles)) {
>   		r = PTR_ERR(timeline_handles);
>   		goto free_syncobj_handles;
>   	}
>   
> -	timeline_points = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
> -				      sizeof(u32) * num_points);
> +	timeline_points = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
> +					    num_points, sizeof(u32));
>   	if (IS_ERR(timeline_points)) {
>   		r = PTR_ERR(timeline_points);
>   		goto free_timeline_handles;

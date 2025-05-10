Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C32C3ABC3
	for <amd-gfx@archiver.kernel.org>; Sat, 10 May 2025 17:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B382010E00F;
	Sat, 10 May 2025 17:20:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jqrPokIT";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9538E10E00F
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 May 2025 17:20:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUIqgdj9EVhhJeDM5iAwdxgSiDJfctDimzawXYKZ0MwU4kEsHqZyG4seyrJxVfcnJpdNvH2u2VvH10Nlt+JGNsRjKMQiUbRvsvALh+SPZqDTQko7zEBqSIzp4/Q1QRkLYKGMJpbQ1FxwbXkykZOWv+OvPgPYcr4Th+EgVLRvPweMbvx7Ylrjz0tER7MOCTR3HsKopguUR3beB1JZU2Z7vD2maAEHyTVd1qkcqFLT0aWlWSc77jh8G5qMDzZneZu01KaDMp8c/Wndni+cgLqR/qf+U6b71L94tEa2CdKnpW3tIefxdirtI14FTnpxp/i9WrtVmbFl2f99SXm3qXbU5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2Bnx/rReyPwSskD2YPbCGulP8Ii3TbUGToUI1CX7ps=;
 b=O4dma6xkAfgi2vURn59U+2Zgmo2DX+2Xr4HtjhPkYZUOlEoUFE7c+qN3Feu7Esp8Xzcn7I2gHDZfDCkjVba67gDDx9C+0PcJ8rWoIGtap2UO5awI++lWS92U04G9H//E7dET79UuFyTZ+aaeEFR9A/bpqq0SVoyjujvyOnX1E+If5U+LSODE62wkkGClh5CXXakyA83kshxnQOskU1dSLotSZLr86fGDJTFWzILqsibZt78JYXnP9oXVP4hUWVvdzK8S0ZbYxQeH5xMtLqtK4IWybhgdJdhmad5T3Fx1Fd0kiekG8L76r5ssKr9KNsYoNhO94xqzTHSVlH4GtfWtNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2Bnx/rReyPwSskD2YPbCGulP8Ii3TbUGToUI1CX7ps=;
 b=jqrPokIT+CxMOEucPqNo75+e9IxKnLX3lUUTqBhYQMSFKzGZzj8CFYiemuO0BAUfXFLCl6WNx+fkD5wC2qkBMJ8nb6yBulOBQKM11ROiiicb+qnX5qg1IrUz+0j6oHRgOPiIAqVfSn4uHHptnpM0ceUEa2lpY3iLMGCW1+fEt9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Sat, 10 May
 2025 17:19:57 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8722.024; Sat, 10 May 2025
 17:19:57 +0000
Message-ID: <88634c72-88f0-40a3-ac1b-0f4e711a6764@amd.com>
Date: Sat, 10 May 2025 13:19:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: drop warning in event_interrupt_isr_v1*()
To: amd-gfx@lists.freedesktop.org,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250507140631.200770-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20250507140631.200770-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL1PR12MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: dd8a4964-1ef0-48cf-d791-08dd8fe6e337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVJVOW9Gb3g0YVhTTkw2MndTY1hadXdIdE9rOU5La0lyaitrc01wNDlTbFRR?=
 =?utf-8?B?Y1VkRFRiV1RvSGxiK2d5QklmTU1pUXBBRldXcHUyWjh5aWJjME5TQXdrU2o0?=
 =?utf-8?B?NWE1RTN5a3Yxd3kzbER5WFJEcE1nQVNxSHdVNGZIMWtMYzJtSVoxblUwekpx?=
 =?utf-8?B?c1hZZHhaYnhNYVpCSXJUN0JCTGVFUkRpdGhhaFFvQmhiUDYwaUR0a0UrZDlD?=
 =?utf-8?B?dWkxVjBZN0V0L2gxbTFKMTZGeTAxT3dDVGF1c0xsTStXL3oyN3NTVFRFa0dz?=
 =?utf-8?B?bmxtclkwdlAxaTlnTnlTbzZPNHVKaGgyajhNc1IxVFlSYWExdVRHL2xjUkNh?=
 =?utf-8?B?M3VYNXFqS0Evd1JjTm1uM2IzSnc3VFVPSndLWTJRdTVMdms5bENlNFM2eHJT?=
 =?utf-8?B?SGhXd1VOK0cySnMweXZBNHFlL1RjWS85WmV6M1J3RjEzdWhLd0Z4MS9lTFcw?=
 =?utf-8?B?MlozeG5LdnRwOS85Rmc1TlNrM1Njem5wZE5TejhPcXV6VXR0cCtFRE5QOWtO?=
 =?utf-8?B?UE8xeXBDSUhnT2lNWWlpYVlmTTZweitPRkhoQmIwL1dtNE91N3FZcklPdmJQ?=
 =?utf-8?B?R0lyUk9HOXU4MTJmQkx1bFQ0a0hOV3NoVW44ZFNHQzgwMEdXbDcwcXg5K245?=
 =?utf-8?B?TjBWMjd5MVFaWExOZEVLVmZ4MGM2QjRUUGFsNTZEbWxLNEVYL3RkWXdIOU1k?=
 =?utf-8?B?OEVJLzREa0dRSEdLTzRrMVlJVmNyNmo4aXY0ZXB3QVF6aXdSVTJReVVCS2s2?=
 =?utf-8?B?U3ZTb2FvRFZpbWJ0NjJNUFRnSkhFeWd2Wi9pWTV3MjFqeUh5bWswM2E0SVE1?=
 =?utf-8?B?dGVJcldacDRWRU1lUmw4YUdjblZEVDhTQlpydVR0MDJveG1vM2psMTk0T09z?=
 =?utf-8?B?amthS1FJclMzZmdzVFhPUTFZOFlVNUZTbU5ZWmpzK0lXTFV3RytoNFFIbXEz?=
 =?utf-8?B?dG1WK3lJNWJuejBRZmU5MVY3bUZGK09Xck43UTJqaW42dklGQVIxTXUrblda?=
 =?utf-8?B?b1ZpenNzWjd3aWdweGxFTjd6L2FkTzJwTFlDTWZKVnBab0RuZ3dUbVpGTG9B?=
 =?utf-8?B?dVhXNGZHSVFsTFg4V242QnY3L1BISUxqNWhwSUUxUURieUYzbXU1L0xqMUY0?=
 =?utf-8?B?T2g2NjdMQ0VnUDk1a2lHS2VaWTJSTFZkdHZpancxZEkrL3RDWmRadFl6b1px?=
 =?utf-8?B?RjlTZi9PaU9Zc2pFM0F3ajQzVXpiTFc4ZTg0UDBaL0E1VWw3UjdLS0V6S3dG?=
 =?utf-8?B?RStDZktTdEVBT1pJYXpncTFhcWdSK29VWjkwcm40NXptS0lDb2FuZUVBeGw3?=
 =?utf-8?B?VHo4ZUdNb0pHeWZucUVlTXZkdCtISkI1VU9HcVEzMi9WY2lIbHZRSmVPdCtj?=
 =?utf-8?B?c1JmOVdlTE84TklGSEpvT0ZxU2pUeVRxbVFybDIzVloyUUJYV09FVkt6Zkth?=
 =?utf-8?B?azFLdUsyVXFZdW5JcmtFb2pDaUVxb0VTYVRrR2M2emNhM0hWaDl5UGsveGZ2?=
 =?utf-8?B?RkpNMmF3MFhLcm9iUDdRV3k5aTNyL3BxU2U3cTNWNlAxcGJpUWUxZnN5em9R?=
 =?utf-8?B?TlFEMjcxbXhEcnhISTFLY0h0VVFiY0MyeFVlcmdKZW0yV21pbXV3R0psdHpE?=
 =?utf-8?B?Zk81YTFFREhKYWxjWlhIOWdDMklteExXR3VpZTRwR0YzeEoxZzc2NXFxbkJh?=
 =?utf-8?B?UEZsZ1htYTRjK2xnbFUvazhpYzc5Y29mNWFEMks0L0owWFdOYzlpWUYveEd4?=
 =?utf-8?B?TFl3d2JMQ3R1dmlmenVtYTlWbHArWGVLUnY4bE8rbHA0WXhiVW9uWWUyTjlV?=
 =?utf-8?B?d3lWTFFkQy9ndlZQS2JJMHVaNmtsUHA2WFJIRUtQc2xwZGpaQkxHdTh5UXFV?=
 =?utf-8?B?ejU3SlEvT2FzMHR4VkFXSHRsa3hQcmFhdjhiYURkZDNWZlZCMU1tWklScDV1?=
 =?utf-8?Q?Tk7PhcKQsyY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTBPWHdaYzg2MzFONnptaTNldVI2UUorOVhBb3pKZEZjR3hRenc0TGp2RG0y?=
 =?utf-8?B?cHNkcFhwQVlNeFVvNjBjVExGa3FEbWpRQWpLWC9oQVptNkdUMGNHdEo5VU9V?=
 =?utf-8?B?UmxCOC9qZVVtUEw3enhvc1UxMXhZOWY1SGpza1dkcTZidlBHbUNhRzFzb1hu?=
 =?utf-8?B?T1VGQXozU0NMbWJKb1VuVjNLd2trY3dqUXZhN2VFNGFWb0RFT3pKK2NQYzRJ?=
 =?utf-8?B?L2REQ0lqVmJMUEJIek1XVTVjcm9LUmZ6dDNodm1YOXlLbmtEbWRTTFVWNlRY?=
 =?utf-8?B?MVNIbkxsOGE2YTJURWFRaTErVk9pT2VhY3ZTVityb2lKeDdDS0RQTm1NYzZv?=
 =?utf-8?B?YnVpUGlEblJ4bWdJTDFoNk1ud29NOGExRUk1N29KZkpRVnp6cjJ2d3NsM0Vt?=
 =?utf-8?B?QjhiQ2xMa1k1TmZLK0VEbDZtRVZuK21xMFdBeFBuYmtudXFYN3pxcE55Smto?=
 =?utf-8?B?TmJPa2F4c28rVVZEYjY5OWhIcTErQ3h2SXVBTVpNWFhrNEc5S05WYjZZR0c0?=
 =?utf-8?B?VWNSVEtmdHNsSkpPdDhrL3d3NlNZdjZwTUtmVExURnMySlNEbEJXRmdaRHhz?=
 =?utf-8?B?bWJnRFdTNVZQZDlaai80alFBSUhyemkyYytheS9jem9EcnBnTEo0RlVYbGZN?=
 =?utf-8?B?V0YzYTFCUmNLdWxoTGpDUmVIbmcxODRWZmZLYitZQVNPK0t4enNRYVNEaGc4?=
 =?utf-8?B?Q3ZsS2dkczRuMzFNempLZjFDTW4zeVZYbHpXUGpDTThDbGNrRU5CRFNOUWJi?=
 =?utf-8?B?bG9jQ05Ta3lzdlhHaWlwM1EvMmJYZ2JCTWNNSnBVL0RRWUprRmNpRk5lTnk5?=
 =?utf-8?B?Q3hvVzM2VnJvY0VhaG9rYWFwMTBacWlBR0VaNkRZZWxPM0FKN2JmYWpZVlUr?=
 =?utf-8?B?U0k1QW9mTzh3bVRGbFFycWJCeVZDV2hNbDNRN0tTQmFyanUzYVlFRWlLTWlw?=
 =?utf-8?B?N1lBS1NqdGYxVnFjUG1aR052TlpQRzdXeEs2S2NJSXNjcHpuZ2xZY2tGRVlu?=
 =?utf-8?B?UkJQUUdMdjR3dUZTVUVUZmhiR0xBSC9yU0hTWWlTbDZ1M045WmhST09MUzM0?=
 =?utf-8?B?YUViZHk0cUMrQ3loNnVkNm1EbU1BM3hlL2I2OVRUL1FIdnZpSkp1bTdiUTNU?=
 =?utf-8?B?MzF2TU4waFVXN0VhSmhnN2ZJemVSdU5uMVRFUnh4bmg3WnZqdENqRnE0eDFp?=
 =?utf-8?B?QnNJc2J3V1duRCtoWSs0SjlRYk5pSXhLZTEwN1d4RGxvTXcyZ01RUkxDRnJB?=
 =?utf-8?B?Zk5abVpKaTNuTlpQbVIvQXhuSzZGTHNxVGpvNjJOSHVSKzlMcDl0Zjl3S083?=
 =?utf-8?B?SVg3NVMxSklsWGJOY0txbzdLdlE2NXlpUUF3eC9MdnVRZnh5d0V6Y1Fvd0NW?=
 =?utf-8?B?MDJ2elhwMSsvMzc1SERBc0xodGM5V1N4UlRJRmZpZVhtMXVnR1JYTVlUUDVT?=
 =?utf-8?B?UDVxTkxSSTh0dnFQZUN0ZFZMZHY4QnorL3VGMExvc25PT2hiWEROU2kzb09Y?=
 =?utf-8?B?ek1OZmtDR2pRMlhmaW02SEJwY0J3UTEzRTE3dmhHeHloYU15cWVoWEZZZ3U0?=
 =?utf-8?B?bDhPT3c1dUI4MEZuMXJSdy9RQVdGZHhPNlVKS2syaGtyZk1WWUVhM2RjekNM?=
 =?utf-8?B?RnhDVnlYZzFZVU5MT0NoZDhVUTcxWDNYTERFMTRJSVMyT2sxenZXb3JObk53?=
 =?utf-8?B?aTNESTdWM0ZURzhGQVVSalNRSU5ZWUdqVmtXT3ZPSURnNCtmTGFrbG54VmVu?=
 =?utf-8?B?K1FWb1czVWZaWVd6SDdScUY5VmJ5dk5OM2RzMDJ0NFV4OC9Ib3VaT3JzMXlz?=
 =?utf-8?B?QmVjcUE0MjE5TlpiQlpSTjZSeDlScVZSQjhOL01MTEhNTy9vZVdydTUraXFG?=
 =?utf-8?B?ckxHU2VwS2RRNVlCWXJWUXRoZDZybEtydnp2bGNvSmljbmZhOGJLbkQrbnYx?=
 =?utf-8?B?RVBwcWczVWJMUXNmTEJyQmlheXVTa2kyYmZja1IwZWpPNm9BSGdCWU9OWFRQ?=
 =?utf-8?B?Mm5PYVZZUGEvT3JjQ2JmZHlrTFU1RXpBTUdvUE8rbDRMUjlxeEU1TVFiODNa?=
 =?utf-8?B?VkhCUVIyVjFDZFVrN3hsWlhYTUhPbVVOYUI5dkZIWW5wMUVNRW1ZOGcvVVNk?=
 =?utf-8?Q?BWGIk1+rJavpe6JtvOaehrkOJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8a4964-1ef0-48cf-d791-08dd8fe6e337
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2025 17:19:57.5767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pDq+fSIdLYjF3DUpEi0d7iUkFDRwQi1mRmUo0O48yg8Pc3wlIgdu8KehX0Upj2xVjg3Gre4Algj1Xv5+uCUaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753
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

On 2025-05-07 10:06, Alex Deucher wrote:
> Commit ded8b3c36f17 ("drm/amdgpu: properly handle GC vs MM in amdgpu_vmid_mgr_init()")
> enables all 16 vmids for MMHUB on GC 10 and newer for KGD since
> there are no KFD resources using MMHUB.  With this change, KFD
> starts seeing MMHUB vmids in it's range with no pasid set.  As
> such there is no need to warn, we can just ignore those interrupts.
>
> Fixes: ded8b3c36f17 ("drm/amdgpu: properly handle GC vs MM in amdgpu_vmid_mgr_init()")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

I think I'm OK with the patch, given that it's in GFX10 and GFX11-specific source files. The warning was mostly there to catch firmware issues on new products.

But the fact that it gets there at all means, that these interrupts weren't being handled by the amdgpu_irq_dispatch handler either. I don't know if you consider that a problem. Either way, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c | 3 +--
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> index 54870b4c50000..3e1ad89747979 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> @@ -175,8 +175,7 @@ static bool event_interrupt_isr_v10(struct kfd_node *dev,
>  		data[0], data[1], data[2], data[3], data[4], data[5], data[6],
>  		data[7]);
>  
> -	/* If there is no valid PASID, it's likely a bug */
> -	if (WARN_ONCE(pasid == 0, "Bug: No PASID in KFD interrupt"))
> +	if (pasid == 0)
>  		return 0;
>  
>  	/* Interrupt types we care about: various signals and faults.
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> index eb88ba8d8b012..2788a52714d10 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> @@ -287,8 +287,7 @@ static bool event_interrupt_isr_v11(struct kfd_node *dev,
>  		data[0], data[1], data[2], data[3], data[4], data[5], data[6],
>  		data[7]);
>  
> -	/* If there is no valid PASID, it's likely a bug */
> -	if (WARN_ONCE(pasid == 0, "Bug: No PASID in KFD interrupt"))
> +	if (pasid == 0)
>  		return false;
>  
>  	/* Interrupt types we care about: various signals and faults.

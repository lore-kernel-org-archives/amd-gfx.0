Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF125C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 11:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48F5910FBF3;
	Tue, 23 Apr 2024 11:29:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nM6A02+M";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C8D810FBF3
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 11:29:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gg3l+k2Rtm+pTRdxg9s4Smc+Y+Y1KeHMJnfCPRLl2yrhK5h2hmillqTXCHFbAshWKBl57ncXtC43w6/5Epxq/0iMcJEPyrFR4lCoxqKYEFE8dFei+Yz44Ofo6Dp+8nk92KgvX7B7VDQUKYarwCZLNs0nuudAS9z4yfeD3w1sPTuwI7vd9Hmc7hOPYkfBy49Q69z0Qt9QGeOEXDK7bGjTYrSMuyw+EOqvaIWFLQ9/rJTU+WcIyI8u3L5EBDEGCMMe27bH8A8tXtn0ah9nRWYI66DhxzsDhR4hOtKLCymhXSN1ZlDu0wnwA+lGWkkrvODmgj5nxnlXG0CB3dlZbjGIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQI/wg6+2G1RC20YtYHgcGjAE/BvoH7/n4HaaRxUgGg=;
 b=EZEYTp11qf/7FD2NfaHv9Xlqpk6NiFrwQAAssK6Z2OFXABjFisP6J73t7zloBC5XkBO3hrRk3AOePrNK8xE9MAIbdlyImABaat1uGtelEsPmi/18MnFBSp+WR5dMdwKTBE2TFez2uc6/fqSGGxGC/H+sRA2+aDkaVJxQ45K+iCrZVkhdozO+06O5O6+sEFCwZ9pdmC2STkqeX2tE9Hvl4fdw/O68dloO00rwnVqQwVu8/LQVPjRcndjjgyuahH7a/RM3r6dwkyTohZsY2c96WAlCDG4mPkJRZKND2RJFNEFIq2w6Dp3woizoexTUPe/wMwfh1bTSNozVc1w5JLuwIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQI/wg6+2G1RC20YtYHgcGjAE/BvoH7/n4HaaRxUgGg=;
 b=nM6A02+MhoycQgCb+1RXmMLqYetTn1s+SPRr4puK32WX4Fu5/InTD/3xaopcOSGDlWG0NLwgBsoTWkuI+7tSWpIl5zF/qMtsY/3jTopNU2ooF/3KF6RsEpjPHeVUO7tP4+ToHiPIhL+EUxO2qjLAAWMHi68Qk5mobvYFN9Re8Eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Tue, 23 Apr 2024 11:29:54 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f7eb:b717:d637:dcf7]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f7eb:b717:d637:dcf7%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 11:29:54 +0000
Message-ID: <e53548e9-6c51-4dc7-9155-201161b372c9@amd.com>
Date: Tue, 23 Apr 2024 13:29:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: fix uninitialized scalar variable warning
To: Tim Huang <tim.huang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20240423084358.1285658-1-tim.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240423084358.1285658-1-tim.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0347.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|DM4PR12MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: f9098193-5ed6-4ef0-ba70-08dc6388b25a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnJRSWZ3K2gvZzcwWkpJSU0waUU4RlM0TzRwTEovKzdjbVJZcVowdVl1anFu?=
 =?utf-8?B?Nk56NXBocEVyaTd2NktYTVhlejhPQitXK2dGNHRndWN3M1Vqc29lQkZzRDlG?=
 =?utf-8?B?eTdVMVpYdk1SSytpNDJhc1NIL3dKLzZwT1MrV3NkMkNpdXB2dmdGc09GRmVQ?=
 =?utf-8?B?T2JDcmh2QjNFL25NV1pmMCtpTGJyWUxBRXlvQzNybGo4NWFxSXlFZFhBamV2?=
 =?utf-8?B?Z2ZBdHdiaE1JcEZoMEkzQ1VCbXNlTjRwREtFWkxVUHhjSXlMYi9zT3ZJaE15?=
 =?utf-8?B?bWEwcHN1S2YrNlR6Nzc5dU1rYy9UVzdqYkVISldZbkRhMlVnOVcvU3VZeHdP?=
 =?utf-8?B?azVQUE5tay9Bc1pISTRLWURJcnpHVmhBTCtEZ2dTZW4zakVBeVE1ck53SEIw?=
 =?utf-8?B?MTd2blpTTVk4bWltQ2JKSmRlUEszMk5DVU5rQXNJbDNVSnpGV2JhT3l5MWpU?=
 =?utf-8?B?cGpLK3NjTWt6czlRaEFUUThhU2xNcWgxUzlRcUl6dFBtYWQ5ak5kalZmSFdK?=
 =?utf-8?B?M1BVcWtNd3pWdytja2tNa254UVJLR0o4K25KSjZadExOWFBjU3prVUtKNGdB?=
 =?utf-8?B?NkpQSWZzSHdBUUVtWXlCRlp2S01BYmVVNnpzaGZCZGFGMXczZTRGWEplOGNF?=
 =?utf-8?B?RXhOZ0h1Sm5zK2g5ZmlscE1JZ05TcmJtUllQT1hidUhUZ3FWZ1pvZExXa3pL?=
 =?utf-8?B?dzlMOFg2RFFyUGUxbU04VWl3OVZkbDFsR0lwRlBTRzFtTUl4OWEwWEJXQmYy?=
 =?utf-8?B?TklYcU1RRHdIM05Od0N5eTJPVnNKTzVVVVR5eDZsMU1JYXk1YWNvS0hrZk11?=
 =?utf-8?B?eXgvS1VoTm5mVXZ5ZlNPWFNzRi8za01PTE5DTXRlZkFnbXNpYXZwbWVqQ0JP?=
 =?utf-8?B?SEsxTXBjTGNVczJuRXFkbzJXbjY0M1YyNVpESEZlVUZFV1JxZUQwSjlJQW9S?=
 =?utf-8?B?cGJ2eHNmZHltZXVNNk83WDBBR2NYd0VUdUM0U2xVQ1k1QXluQ0VFR3EyczFL?=
 =?utf-8?B?T3BDV3lTMmN3Zk5mbFJ5WkoyVzJSN29VZHI5djhrTjg1TlA3YW5WWGlId0Nl?=
 =?utf-8?B?RmZIRFowQ2xSTFdjcC9ZZU1maFkwZ0hBejRiMzBIeUVqcCtQcnhUeVcvZkVr?=
 =?utf-8?B?dEROcXhzWkN6RU5hNUlnYWpOdEJyMmxiWVVMZTRiWXdQMmVDKzZDSnRZd1NT?=
 =?utf-8?B?M2t2OXlvSGFhMFdzeXJLTnMxdjBPWGFocEtGL0tSMmI3MWFDa0h0N1JjWm92?=
 =?utf-8?B?QzMxUElEWFJwcFZWdDJSRE9UUlBYR1JJajNUaldHa2UzOHFiMTJSbURlMUR0?=
 =?utf-8?B?aU9KeDB4QXNZNUpoSGRVVTVBWWpHaHhqY2grOGtkbExLMUo4UWxtRUloSzNE?=
 =?utf-8?B?QTN1Tk9rSTJkY2FNU00rWHNKVVFKcUFMbnRZY3h0alptbkRIZGZaQ0I2Szda?=
 =?utf-8?B?SkNRaE51WFZIV1UrcmcwNnAvbCtFM0RyaHA3MHR1cGhEK2dPOWNabTlDSlYy?=
 =?utf-8?B?SGZHRmdXVlN5Y3ZOMkplclF1ckZQTjdKY1J5TjVMUzMzNDV5TlNXTnBSeU04?=
 =?utf-8?B?WjIwSXg1SzArZFNmM1VNUzdxQ2hxRlJNajBCVVp2ZTU5N2JwV0pzSUZvaGhK?=
 =?utf-8?B?SFh5NnB3Qys1aEVnOHBET1h1YTBJKy85V2FUeHllQkk1SmZvdEFtaUZzR0ht?=
 =?utf-8?B?OUExd1NvdCsxNnNMdWFsM29Odk5EdG5TQ1l4WGpnQ29WZzFBL05abnJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUpmTld4OERQT2h5d3YvZW9HbWhDZ0RzblJOWTFaazM1MGFDclV3YmxLcnhQ?=
 =?utf-8?B?dE1RZCs4YTdMbklTaS94dWpBQ2dpaVpFQ0lhN2VNOHBxVStZSjk1TFNmRjhX?=
 =?utf-8?B?S1ZHWEFLZldNeC9FbUFJY005YXhRamNUMVFsN3AyS3Y3MnhReFBtV3NoNm9H?=
 =?utf-8?B?NUdQajhtYkVYTkIrK1lWNU5PK3ZTZGRzRUQ3TzdWWWpianRiaG5ycHBJb1Jr?=
 =?utf-8?B?RlZhTEgrQ1NJMEtrL3A5bHBuTGlHZ0p3a1lSbFoyblR4eTlKdWRqaHV0TnJ2?=
 =?utf-8?B?S1o4RWNHZ3BMdHNsRE5BTHN6bGNTWjgvcnltN0trK3ZUQ3RNSUJwZEdhRk1O?=
 =?utf-8?B?QTkxY1J3VTN1ZHhMMXdoYmZjQXBqUEgrZTIzSlVBd1lqMXVORjNtMjV2ZE41?=
 =?utf-8?B?d0NrZjM4S0VmcVJxbXpqdnFoVXF3a29QWjRKOURIVGlyWGU4UlJ2Y2F6L1pl?=
 =?utf-8?B?dk5YbS90czFwemVwZDVoQ2RSN0RtMVNRTG9DaTdiYi95SkpFNFo2WHdCTllk?=
 =?utf-8?B?ZGN4RkpOMlpiRWpud3k3ODhtcTRTU090b09LK2JMSXZPSDhST0JOdlNNalM5?=
 =?utf-8?B?alBNb1RkZFFmVFdpdkVkb3k0TnBiTzFlTFNuK1AvYjV2dkNyZXluWDY2OEo4?=
 =?utf-8?B?L2J3QkJVUzhYL1d6VWUrNUtsN0RUVnVPOEFMUXJpZWVZWlhSYW9tREJqNjZs?=
 =?utf-8?B?MzVBWEFJNnpMUmFBVXlzbTFlWnpMaEdpby81WmY5ZnBQaGo4Z205blN4MnBH?=
 =?utf-8?B?dndiSlU3VmZ5WDZzSlNuZzRIK3dhRkhJOGtRMFQzdWIvR2kxYkJQY2NWd1ZP?=
 =?utf-8?B?djlaK0g0Si8vVXp2MXpjMy9hN3FXem5lOHllVTAzT1p1Q0drelNnalJFekw2?=
 =?utf-8?B?ZFR1V2x5QTBrV2drQjBXVWtkSE13b0FDUnhBSHcwUXJxdk9FcTNXdCtvbkJX?=
 =?utf-8?B?enpkTTcxSGxxY0ZBY3hQd3hYalByODJHblNZeEV5emxkWkowS2lHcllxaUxp?=
 =?utf-8?B?MkhPZ2k2WkNhcllxdkJXS0ZlMWNoL3VLK0wxcU9XaU94Y0J0Yk5paTEzOUZp?=
 =?utf-8?B?S281ZWpMMUlKaFFjSDJFNDRERTc3ZTVhTlNJcCtZLzREVlBVZHMzYnhBekdt?=
 =?utf-8?B?Z0szNVQwMHhiR2tXdjZWSkJpNnpFaHpBTEtEdXc5TzhBdzFib0QvbWhydS8x?=
 =?utf-8?B?U3NaWWp1RzFmYXpiM2ptM0hMQUFVeGw2WVAzL2IycFY1RHpMQ1dZRFdJeVIr?=
 =?utf-8?B?YjkyVytlSDRIYW9MSVZ2K2hNRU0vams2bEFWeDk0T0VpRzZSMytHU2dFL09r?=
 =?utf-8?B?NUVZZE5US1F0aDZ0M2xKMmFuUXI5cVM4ZVY4U2lOcmJpdmJ0TUZLWlBva1Rq?=
 =?utf-8?B?eCs4T3F1SGJSQVkwVXBjV0FoY3hHbkpuTlVlS2dOaDRmMUoxQWhWeDNEL0JH?=
 =?utf-8?B?UU5BbkxyRjZzSGMvVkRJTTJsRTZiS3VXOHRYSmlEQ1F0cWNycnlnYksraHZh?=
 =?utf-8?B?TGIyYXl6bUFFaEpSRlZ4M2NmVW5hcjVMb2xVRm9DbG5RV2xXQUh5Ym0zVWpq?=
 =?utf-8?B?d2ZoK3VUQmtCRDJFbHVLeUNVMytjeGRTNDRYVzQ3UmVlcTByTkhrR29VR2tN?=
 =?utf-8?B?LytQcmFTZ0s1cGVWV3RaeGJaTmU5dkVoTFhYYkxYd21nc0NieG43c0pBeVc4?=
 =?utf-8?B?QWdmb08wb2JERVpkSXZTMDhJM1FrbWtoVFJQVUNDWmg1Si84Mk9vc0FTbHNk?=
 =?utf-8?B?a1N5dDBIQ2dNUTZnZHlXOFVIejMzTW9pTVI4R3FaOTZZMXNOdVV3MEdUQzF1?=
 =?utf-8?B?RXBmcmRsYjNSNll6dVc3WFJaYVVKRHBadllFWnFxYkt4R05yc3NCSEtLM0Vm?=
 =?utf-8?B?OGxtZDJJUC9OMjF5NGdyMi81T1haUGo2RVNJU1hxVndPeVZjZG5PTm5LTHdG?=
 =?utf-8?B?QzJ6L2V3QTFuMTlLM1pncGUwS01oQmV3V0Y2UzdLYnhkMndKRmZuZ3k5V2Fs?=
 =?utf-8?B?MFRxLzdvb2pidE9xMVI0Wno4c2Y5ZzJsbTI4cXRPcU1taVQwdGpZNUNFUGR0?=
 =?utf-8?B?TTVmVk41Ky9WSlJ0ZGJFcHdFeTZhRFdSUmVtekhXSnV3MDJ2aTVDeVJjVWx1?=
 =?utf-8?Q?Pm7EE5J6xEJh1Zi8rT+JERwY9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9098193-5ed6-4ef0-ba70-08dc6388b25a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 11:29:54.4211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfZYsJvAjLL/fwsmZRgHeXQrlpQ0E8Hm4/U6Pf4f/xUpEGSSI4wUXqGa5gyzFZ05
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232
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

Am 23.04.24 um 10:43 schrieb Tim Huang:
> From: Tim Huang <Tim.Huang@amd.com>
>
> Clear warning that uses uninitialized value fw_size.
>
> Signed-off-by: Tim Huang <Tim.Huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index d95555dc5485..8d5cdbb99d8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1084,7 +1084,7 @@ void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev,
>   	const struct gfx_firmware_header_v2_0 *cp_hdr_v2_0;
>   	struct amdgpu_firmware_info *info = NULL;
>   	const struct firmware *ucode_fw;
> -	unsigned int fw_size;
> +	unsigned int fw_size = 0;

You don't need that any more when the default case returns.

Regards,
Christian.

>   
>   	switch (ucode_id) {
>   	case AMDGPU_UCODE_ID_CP_PFP:
> @@ -1205,7 +1205,8 @@ void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev,
>   		fw_size = le32_to_cpu(cp_hdr_v2_0->data_size_bytes);
>   		break;
>   	default:
> -		break;
> +		dev_err(adev->dev, "Invalid ucode id %u\n", ucode_id);
> +		return;
>   	}
>   
>   	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {


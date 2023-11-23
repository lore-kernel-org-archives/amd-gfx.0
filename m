Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54967C5AD4C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 18:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C147010E172;
	Thu, 23 Nov 2023 18:26:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADE8910E172
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 18:26:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GI268YDn8ZQmiTQpGEWEbupGv/rUP+H3OjUpITAWeHUPxL67vZS3pcDQcEyhNjn7EhWmT3RU/bubRdoJfgr9tlWhX49YeSCX/aYuBWV+eM6GRctMf4Y7F5fIPUwhICA6P3Pyzy2co8q3AzlQxrXe1kq5ig4hCHq5rZ19sl9tEpmxP0q3UP1kZiFLVXFzQrsJs0kXvvmRJ5JVjFsi04QSH/cABsc3RaoNWgEHIf0N4JB/qbT0XvFJ/RrikMTpXxDz7RPvTiFV3/w6pFNP8XvUa/Cp9mH7VE9YeO2X8T2mNtMNseapzNo0yjstqUuqpqyhfH+bmWoumv9ofgBcwYD6IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuXW4Pj+xTFCelRrDPRUz80KB6Xmk6Wyo31EMYSFt6o=;
 b=izDc51JlxU2+W0T57HhkWm8ivGeoYvAjFJgmd2223rII29YxhnUYOYuGa11JsiV7rMS55tu6UIkqz+LVgcn22dwmNJY8rfTHGpLc5PKnje+8R3m70YHoG50PE1xrFalLxhUgTDjLkIDIckr3oLGD8Z9EUgdC4C+xPUkjNYyp19Ruyx56CZygq6ICJ3bY0sNAV5IUlxCn73imVtcwcF78Ca0SGpCw36cMphVfSX85XX0c1asjlO3FYAV5ByJPeTn5ud/V2BBJ/GkRtcYnZDklc6myEs1r81QjCMnT+TZ7gtvdgYgigGm9AH3Z/gbe/fRVseM4vV73+dXkAhhgV183vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuXW4Pj+xTFCelRrDPRUz80KB6Xmk6Wyo31EMYSFt6o=;
 b=YAqA+vNNEW2mcZTqHA02boGhYDeeUsVkLP++E2t1CVitRcOdQi9lRaE9VceXnvwf21TrEFDozVwnBqBLXdGZIAC/dToo7hTr3LJoAJabSZLwQ1inN/eqGT8/qdzM2eU8uJY0AYwGwLnhDHBrT3dPOD5vqN0LcpnCAmakERXY1Es=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 LV8PR12MB9083.namprd12.prod.outlook.com (2603:10b6:408:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 18:26:37 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5358:4ba6:417e:c368]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5358:4ba6:417e:c368%6]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 18:26:37 +0000
Message-ID: <8ea2db7e-34f9-4400-ba0a-d4cbd6a0de5c@amd.com>
Date: Thu, 23 Nov 2023 13:26:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Enable GFXOFF During Compute for GFX11
Content-Language: en-US
To: Ori Messinger <Ori.Messinger@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231123175842.97383-1-Ori.Messinger@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20231123175842.97383-1-Ori.Messinger@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::13) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|LV8PR12MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: f1508285-4388-4abe-6d45-08dbec51baa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r65GerbJfWufxxTrZCsCGQgUSJQfod6imX9F1/LENSzKqy0FAZ4quj4W7gQyxhWHBXcTNEAArYQxOgfoHjSzR5ayJeEPiPVj4VR5S2uoMyB1b0KzfVA8qG80CLX1XDtxFBa5oaHALszDK/B1UfI5b8aiyipAlkfs7Gl/K4rfeZ2QOXymoSeXE+Y0/wS1Aj+wtL89hw0mkhq5q0VLPgvj6jUZM2Qt/JOsTkx+nvuEIXW/8qTkTCGf7CiAH+Dqrj5IAax5bNDy+VMaFzaDUqyDadNOD7pvuDF7EJAgeuEwgge8u7ku4/H54OwG3FzudAW9I75+X7jCcoYImuth8J4VhkECx3eLRDKER+Bv215Zd4Oy/+niVMhyIwJmRVy1ogU/DbYa1ZoJXCCgGMbBXGnD8H8doRX6azngm7iNt7eZG+ClPft1Lm9gIrCKawD3BrMykmFfnR+Cz8KmGx08U1X1cUVMcEybRMRt7Z0iKI0pYhNCzKbo+3VGOHUmAVgu+nEw872aATqv4+30EyB0obWT7jBZn5JiGu5KGY1mONIXynwS1GPhC84wXWe3XJGxPPoVgbfErJD9cDs+PduwLhIrekWqsF1NBa7jHUprdLBVpPKVMtt7EB7NOzjLuk9BejJHQ8zl5967pkGLao9mTLahVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(83380400001)(478600001)(36756003)(66946007)(66556008)(66476007)(2616005)(38100700002)(6512007)(316002)(6486002)(44832011)(53546011)(8936002)(8676002)(5660300002)(6506007)(6666004)(31696002)(26005)(31686004)(86362001)(2906002)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0VRRUpXMnRRclpUeG9taXZWdDNvVGFJWi85TXQ3MlZDazVJVUNZSjdrZEM3?=
 =?utf-8?B?NmhFRFNoVlpJMnlmOVZ0OGpsSHRNbHFmV21CcXY2Wk85SFNkZHl3eDZLQzh0?=
 =?utf-8?B?VitPUDBqY0RvSTA4SmlzUWFPQ1hHTU5Ea2lpcVQzYXc5aGgrb3hyc1ZZVjNW?=
 =?utf-8?B?QjI0dWZwNmhZc0xiVFROR24zQmNXMXQvenNDN2dRRGIrL0NHNVM0VFRNS040?=
 =?utf-8?B?STJBZk9RaExYaWI2WmYwWVFFb2lVcDRRWEVGd0hDaXZPNkMzeHpJSWoyYUxR?=
 =?utf-8?B?dlZMeTRWcTExUE96eGNiODdyb0NpVkZwNHd1U0tYbUdrNWlyMFBFWDBPNTU3?=
 =?utf-8?B?dGMxczlCakFsQ0xlQ2ZydjhyQ0x0T3FCanc2czlPSkltd0RwUlM4c3BhS1lN?=
 =?utf-8?B?Rjd3dWg1VGZPRThORzR3aUM0ck4vbVk1Y2FpaU8rNmgwT21NeTJtVkhpN204?=
 =?utf-8?B?bEpUT2EyUklQdnErZzg5VFpQT0t3VGFTUHFpSDFia3hvK1lTOWl4MUcyRU12?=
 =?utf-8?B?WVpGYkpTQ0V1T1FtQ3lYWUt6UXRNbWdobmVKSW1rS3lFM1pYVElISnlSSDda?=
 =?utf-8?B?YjNVRGtMN0xmcVFjQzQ2OWV3djBQYmpMZ01iSWpRR3J3bEROOTNWeEozSVE2?=
 =?utf-8?B?K1E5cWRGeXd0ekdBSTNRa3BFVnFHZlB4UjYreW1qb3A0THJRNVBmOHZHL2hr?=
 =?utf-8?B?cDVPZkxnTERLSlYwVUt5a3BGTG5KRE5rTjE2U2dUdk1KTnIxODhxM3pWN3VO?=
 =?utf-8?B?ZXZsL09ZMExSNXdPRkZiZGdvWUFaYTdRdWh1OGlHVXlLanB5MkR0eWtKTTY1?=
 =?utf-8?B?WGVzazJnL1lsWXRVeUFaODduNEZyZ2habHRuVUI3YWVNVzNYUS90L3RqUWc5?=
 =?utf-8?B?V1dkTjYxNE1rVE0yU0poc211a1NkWWMrSGp4dzQvR25Qc3pBTnl4Q0FEM3Bp?=
 =?utf-8?B?MEl5QXNxUUtnK0tTSU1DNmFTUW1HWnYxc25QTHMvS2J0MHMza1RKd0lJVSsx?=
 =?utf-8?B?RU52YzBsWU96TE5PNjBGKzZGLzhnT2FpelhxVWp5R2dPSkNBcjdSbThweTh3?=
 =?utf-8?B?YUZJdW10Z3RpZ002ZVNRckR3QUZLQVgzalBWN2JNcUNlWm9palhWSXI2V1Bj?=
 =?utf-8?B?NlhvcEtWcVBSZVkyRXZCS3VlYkZta3A5VU40cFR3RVBEVFF4VUlqcjlGYXp3?=
 =?utf-8?B?azZRUXpmYzJ3Ry9GNXh3cVVkN3ZYcHZWaW5kdVdJZFNyMyt6eUtVSEVsRW5X?=
 =?utf-8?B?R29UTkVsTm9RRW0weFBOb2piNTQvMmVhdVFQTVVFa01ZRll3VmdMUG9NRTEz?=
 =?utf-8?B?ODc1QU40TXRPZ3dkVXpPWXR0cXRUZzZKdHJ0Ris0bEk0TDBCelZGUUVhUzlZ?=
 =?utf-8?B?a3ZvcC9Wc1hvZEhYZE0xVTlSdXJsdGZOdGQxZzdWQUF4T1NpUXBDRUdFYitZ?=
 =?utf-8?B?QXNmV0hJUXQzRXhscTlPbVo5RnJMOEM0bGIrUHRucFAyRk1TQ1JZV281Qzcz?=
 =?utf-8?B?WXJ0bXRVazJaWlozMUVaNDhtMUM5NWlkQ2JpK2tkVk9DYkMwODF5Z0hEU3ky?=
 =?utf-8?B?dVNmamoyeDY4VjM1ZGRCM2RwTDM4emtneUZUZGplTlJNMDhwenZkcXdkWWFl?=
 =?utf-8?B?cHZpWFR1ZXgxWUFhM29BbjJWNDkwWStwSkpoejdUM1pDQXB4YWpzL3gxRjdi?=
 =?utf-8?B?dWhMejhHRXFscmk1OFZHOW1RVXZQaTFvUlVFWWZRSndpQkNZMTZ4dFBmR285?=
 =?utf-8?B?RUFsazdZVFhCY1NIQWJ3bHppd0VnK2RlRzVJY3NSZjdkRkZpKzhIZVFkRmtU?=
 =?utf-8?B?eWlwWTZUZ1UwaGh1YXR4SE5tbmdYdy9OcEVkdUFkNHhsTEttUVkwTlNjK2Iv?=
 =?utf-8?B?L1poU21taHc0aDg0UlhhNFdXRDVTY1hSc2lKQnh5Q0VjU3BVbkEzUDlZTzZi?=
 =?utf-8?B?SWhESVZnTy9odHFTUGY3bWxFelliY2pXQnVzV2xtTUcrT2N4dzgwRjJaeEk3?=
 =?utf-8?B?NXFVRG5seUx1elRrMks4R3J2K1FuK3BvNjFGRTlDS3QraDEyeU5jdkJHUWNX?=
 =?utf-8?B?S0ZjaFFLUmZXMi92WldiOUJkUGRUUm8vdHQ0RElGK25RaHROdm5kY2p0alI5?=
 =?utf-8?Q?h/jRk6QKhCXdFF/iFubtQTpbu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1508285-4388-4abe-6d45-08dbec51baa2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 18:26:37.2202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpX6lYgSGpsQrUeABNa7GrM/WlMD/BGk/wqM5m1Z3Sz1rDamBKRZAUKc53SB4Jl8g7VVsGimJ/C/+eg90K3O+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9083
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

On 11/23/23 12:58, Ori Messinger wrote:
> GFXOFF was previously disabled as a temporary workaround for GFX11
> due to issues in some compute applications.
> This patch re-enables GFXOFF for GFX version 11.

Please describe what has changed since it was disabled, that allows us
to re-enable it without encountering the same issues.

> 
> Signed-off-by: Ori Messinger <Ori.Messinger@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 2d22f7d45512..bfd54877b8c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -684,14 +684,8 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
>   void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
>   {
>   	enum amd_powergating_state state = idle ? AMD_PG_STATE_GATE : AMD_PG_STATE_UNGATE;
> -	/* Temporary workaround to fix issues observed in some
> -	 * compute applications when GFXOFF is enabled on GFX11.
> -	 */
> -	if (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 11) {
> -		pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled");
> -		amdgpu_gfx_off_ctrl(adev, idle);
> -	} else if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 9) &&
> -		(adev->flags & AMD_IS_APU)) {
> +	if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 9) &&
> +	    (adev->flags & AMD_IS_APU)) {
>   		/* Disable GFXOFF and PG. Temporary workaround
>   		 * to fix some compute applications issue on GFX9.
>   		 */
-- 
Hamza


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C74606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=C9TogYPi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 953BA112357;
	Thu, 29 Oct 2026 14:33:38 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B980B112357
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 14:33:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kn83asaJwGJYEX3WsljlEo0yzDcM2Lu/iYZs7vOkDhv3RVXMIBSIzqjW9iTWeE9sMCaVEuMYwrhVKBdfWoGURjNIpFHRmF+qfXY74UpKoWbTiDi0qzUSFOJ+bm4JvIS5CS1anO4FpV6/EBHmJ85m4soMgocYWvsHE1v791jjwFVRP1Td6exo5cMC+rCl0eDyZ/Ej/oi8IDCdSgCggpoDd7PaSPcF2RNC5DqM9kl+OhilcOAq/bNkKU0U1JF+45Wwjkc2AjWz1u8iXBL+WdB0ILfbvEBH+oTBxXBKR/1xDUuUc2xRW/FvHgJ2sjakBopXflpr6pahSsTcYPUXJWJKUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPkrTw7S+vLYEzoSVE8eiwSqSnCc8bi0ip6kCTYmfQ8=;
 b=lS47vxnhDn6EqLdDTo5gVISfuEGyex4ehoYdvsW+kxqaBNTUNryD6CtzT7tox6QiUl6FkqRUW4PR+Qdvk+dcZfQ7JQ5cX2OeGaCxGEQVV4hhjTRnZkFmFDFMPmJQRT4rWShZjEQzq1AUK9aIf1OKZ7TsRLUR25Yf2eRRIx7Y94ZaVgXR6bT/8XLNMnTH7y03hP9CA/11iK3kc/Fa+j8GEznAhtHKDIsvb2Awx9TnQDqquq5KEnNlx3eyaj9omu2cw3XirjFvL7xQVmLJiC6BCrDYYdPFE1AMBmtIS0qQZXjo8ERcpiv+vhJM+ifqdOgz/5BxOImWMAC755w3gjG83w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPkrTw7S+vLYEzoSVE8eiwSqSnCc8bi0ip6kCTYmfQ8=;
 b=C9TogYPi7UzMtPQzv3fifAtFpdRm6Dq2p2ip0ZZ0PGrZOerGukmYyzP2pP/jkwcAeerdpWY/gVf8sG9G87TFaKsZ8TSsLVnToVtbHsWrlWNjvghA31FYlj85h84igbwDQFBK27iGCrPosISewTe9170d3EP/1u3LYnRdkqvdObA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 14:33:27 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 14:33:26 +0000
Message-ID: <3053238a-4650-49c9-9967-1ee92a7891cc@amd.com>
Date: Thu, 29 Oct 2026 20:03:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: abort SPM VF init when the HBM aperture
 is missing
To: "Xie, Chenglei" <Chenglei.Xie@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Luo, Zhigang" <Zhigang.Luo@amd.com>
References: <20261022153132.211631-1-Chenglei.Xie@amd.com>
 <20261022153132.211631-2-Chenglei.Xie@amd.com>
 <70f8340a-267e-4bba-9611-07406c552cb7@amd.com>
 <SJ1PR12MB612197EEC1C26B3661FE750B806E2@SJ1PR12MB6121.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <SJ1PR12MB612197EEC1C26B3661FE750B806E2@SJ1PR12MB6121.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0273.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21d::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e7772a-53b6-4b13-5e77-08df35c997bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261028144727099003|4143699003|11063799006|56012099006|261009223027099003|261022105027099003|261022075727099003|261026121527099003|261026140227099003|261021123027099003|10067099003|261021121427099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: TfFV1aBpIWOhiZkZ4ExbEP1+0X+aFCB3rLGpcMFh+7sX8ah2jdJmv2Ia9tI5JWC1W+oc6aU/8JEu/g9rPsMCcsg/RysPSMY39TlFPsEdhibCD9XC0TEOLxjSRS/JfSc8b+R9eYOgZwHyr/wYIjvzxQEZuVSVgq6VVrSyGQG2lG3VHxf6A0k9E0AbM5nzcUd6+pCqEK46uLqmeWwIuB1Gu2gexUSvMGaL+/YKMfLeTBtfxyHWRkJHSPPcKpWUe8CgT457bkCco69+EXnkl0fPaWpOXpUKwC92s/3cyDHGganYW2E+zqg2Mw59RrvQYxAjkKEHx2IuA2DH6MAVWkFLf2tmP0Y22Hx/vcI/snWnup/4rmMLs9EGrNCXQW5p6l1EulaXKHLK73URLnOdI0JObvOx4xSsSNsXXd9K4++0z5FCjNg5HIB0pIE0zPVn5Gr+vevbs2/y4BxU+c+ECCTdX8WtGarWdI8KiFsCOlWfkP/f32j4Qn3lu4oluMzB8hGePSCU3KARv84ZBnUPJZKBhjebRKxtiu9yqj6MA48g4hdosnMvnt+4yhAiguF3iIyAjRoaTiNO39R3cvsExzK6Zt6b8WT0pUFN8h/0Ia6jV777qiWDrUrzE71XMTMi63OIK9yisaNYsFwnaKhC5X9LHcWs0pCfgbbsU8HE9iRUBUg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261028144727099003)(4143699003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261021123027099003)(10067099003)(261021121427099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGlEVm1KM0J1dXI5d1NGbE1ubXkyRFJQUnJ4YUxHdUJYOHBOTnVMeEFmRVdM?=
 =?utf-8?B?U1kvdGYzWmlkemZXVEI5RkhsQnRRK1lBYWxOdWNTWkw2bFRsRE9kSVF3V3da?=
 =?utf-8?B?Zk5RemVCTEFrSmwrcmovbG0xQXNjRkpvY25xZEw2NWh2V2pINmhSVnNTYWhm?=
 =?utf-8?B?WEZEaW1hTU5BaGF3eGg1YmxlTjdldjl2UE1XQUkxMysvYzF6MmRNWmRUNzln?=
 =?utf-8?B?TWl3VzVlT0FSLzBVR0ZYRGZEaVA1Ti9pRUtkU1NMclBtc3ljajM2bklLdlpB?=
 =?utf-8?B?SmNiNnNGNnNUcW5CdlBXQnlvYzFETzlmYXkxVVZRR3VqcDZoK2lseHZHMEs1?=
 =?utf-8?B?cXlEZzUvekhEWjM1akxtMXNIemRCNlFLRi9GRURjemFoRFE1ZHE0bXRvbW1p?=
 =?utf-8?B?Y1J5QVkrR1B5cVBEQndROURWUjdLc2I2SHZaQW4rek5NdnNkYjNqU0hCUzZZ?=
 =?utf-8?B?QlRtUnJuRDViTW1sQVFuMGZQUzBOaVZlTmxBSlhncWVCSkdwMkJkR1BDSDBm?=
 =?utf-8?B?WWZjZE1ua2VkNW9kTE4rVjNhNlVwU1o1MWJkampDU1VqRlBESjNRYVVnY3Zh?=
 =?utf-8?B?VFpmUjQrU21oK1JsU3BncW00aGQrV3BwOTZVQytJVEd4aVIrNDR4L2xDM1dN?=
 =?utf-8?B?ODd5SWVLV0FtNUs2OHBuc1BjNUlvZWpqcDBIRVc4YWV1ZSt3YjBydlVHUTYr?=
 =?utf-8?B?TG1ibmI0S3NWY3hVRktZY3BNQ2Z3OFpQZWRMdlc0WkczcC81b3pTb0RqRzNI?=
 =?utf-8?B?TzBGeXdtYWVlcXlDNmdhK2xSYUMzdjlhNGoydVJNQ2YvK3VnVExZMkdodWht?=
 =?utf-8?B?M0xQaGI1MnpiMEQrc28wTmtlRWg5ejd4WklPU2lKY3g1a1FJczVHZEVQWXpE?=
 =?utf-8?B?a0JrdWIzTVAwUkJRdW9kTXpOa1ptU0h5WWlwWXpjc2NJcDRGeEplKzA5MGVM?=
 =?utf-8?B?Z2RXYW1YVjR4bSt4L0M0ZVRZdytaanIrc21wVkxzdXlNWjJCaTE2QjdJWnVG?=
 =?utf-8?B?M1p6OGVPeGFnc1JoS2QwUW9sWW1qL2xsUFNMZXB3NHU0TS9STGtSWE1kK0Fj?=
 =?utf-8?B?R0l3ZzJXN3Vuc0FyazNEb0owQmkwZ2xucG1JQUVSNkNPWmxCUDZRa3FuMTAz?=
 =?utf-8?B?dlhGbW1HUktIVngxS3NKNzFIVk1zOVVtbTdQNW9STkhnQ1lhVFIrQkZNRkRI?=
 =?utf-8?B?MkYybXBQb2k0UUl2dHlnYzE4UkRRaUVwK2poQ09MN1FKdkcxT2QzT0NBUEha?=
 =?utf-8?B?OGxWWE9SU084L3JLV2UrNExBVi9aTVBFTzUvZWRHdHJwUE9ueEdRWXI5S1RM?=
 =?utf-8?B?Mjh5Y1RtVllWdEZKN043QTZDNVZvdDk0OW05NklickwzbTd0eU14RGllTkxH?=
 =?utf-8?B?enlMSEE0Q2EreHV3N2c1OHBER05pTmpzUDQ0ZUFicnpkbjJFcDZzeHVKWVlO?=
 =?utf-8?B?WXB6S1Q5WGwyWk5vY2xwbEc5QVJPUjVsLzFlNXlHYlJaTjFhdDlkeWUyMkRQ?=
 =?utf-8?B?MmhuQkJ0ZjgxaWpJd2o2bzBsWk5BbENYRG5KdjJNUnRLOGZ5WEFpemo1WmlB?=
 =?utf-8?B?d0FabVBTOUZsUUxQaHNlOGFqakpMTGQ2dmZTSkRmNzgreElkQ2JKRlR2UTBF?=
 =?utf-8?B?TkIwdGUxQm9aZjlGVHpOc05PMkNEVXBvcjBGRXpzeENtSDJ0RkpXalVpTE9E?=
 =?utf-8?B?c0RGbHhZRmNZTXpUZkhqeUpTSi9qL09Td3ZiMEx0VUJsWWx0aDh3YXRxbXN2?=
 =?utf-8?B?V0k4WXlxc3FkS29DbkV5ZFBzTDZFTmhMSnNhQWNVS203VHlWOHRvWkx2RHhW?=
 =?utf-8?B?cTBCc0xCUkVCR2hPK1hNVXZienplQUZrUGZsbjdDeGc0bm1LMm9pc0JMSktX?=
 =?utf-8?B?U1JLanROMThDRmJsSjN1SmdWelZ4akZQVU9oRm5jd0tyajIreEMxREpHYndG?=
 =?utf-8?B?NDFSZmJkZ2luQXRMMjZiblJKelF2akJPRGIrK1ZFME9JSUhFaXRuZTFUeFcy?=
 =?utf-8?B?NEx4cXJmU3FndVpickFKSzUzbmVlSnk4NXl3UFJmcWg3aWtHa1djbE9mOGw4?=
 =?utf-8?B?TmErTnZ3aDE2V3FhR2FDdTdZWTZFbDN5K2wrWjY1M2l1L0Vub3ZrU3l2QmNQ?=
 =?utf-8?B?ZVYvTU03T3U3c243SU1KTWZSd3A5dWJuM1JGbTJkWWFZeTNGU3JTbm5scWpP?=
 =?utf-8?B?REZvc0lxaVlCOGEwYUZzZWJWeUM3OEtPVzFUVFFnbC9SVkx3cXhWNE9FSVFO?=
 =?utf-8?B?TFJZckFITVMvZU1aN2c4TmxJeTdUMENnT25laEJJbXJ3eHluRzkvQnUwYXUr?=
 =?utf-8?Q?YgRyUvhT9Y1gzbcWnA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e7772a-53b6-4b13-5e77-08df35c997bc
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:33:26.2931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gTaMGAgVH7RmO1p+hIx2EPbLMb6IousmnTnXTrzSrFlH2fcacVvhegAYpJ5jNfJl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 29-Oct-26 7:25 PM, Xie, Chenglei wrote:
> AMD General
> 
> Thanks Lijo, please review if my reply on the comments make sense.
> 
> Regards,
> Chenglei
> 
> On 22-Oct-26 9:01 PM, Chenglei Xie wrote:
> 
>     An SPM-backed SR-IOV VF has no usable FB BAR, so gmc_v12_0_early_init()
>     resolves the VF HBM aperture from the SRAT. When that lookup fails the
>     code returned -ENOENT, which the early init loop treats as the GMC block
>     being absent. The probe then keeps going without a memory controller and
>     only dies much later with -ENOMEM, far from the real cause.
> 
>     Return -ENODEV instead so the early init loop aborts this GPU probe
>     at the
>     point it actually failed. Other GPUs probe independently and are not
>     affected.
> 
>     Aborting here also exposes a second problem. On a legacy host the VF
>     takes
>     exclusive GPU access at the start of early init, and every error path
>     returned directly without giving it back. The host then waited for a
>     release that never came, timed out, and recovered the VF with an FLR.
>     Route the post-acquisition failures through a common
>     err_release_full_gpu
>     label that releases full GPU access before returning.
> 
>     early init also fails before the CP scheduler is programmed, so the host
>     treats the VF as not active once it sees the release. Clear
>     AMDGPU_SRIOV_CAPS_RUNTIME and drop adev->virt.ops at the same label
>     so the
>     later fini path does not send a REQ_GPU_FINI that the host will never
>     answer.
> 
>     Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
>     ---
>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 ++++++++++++++++------
>     drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 11 ++++-
>     2 files changed, 43 insertions(+), 15 deletions(-)
> 
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/
>     gpu/drm/amd/amdgpu/amdgpu_device.c
>     index 5069042b5279..10002b78c69d 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     @@ -1999,7 +1999,7 @@ static int amdgpu_device_ip_early_init(struct
>     amdgpu_device adev)
>     r = amdgpu_virt_init_critical_region(adev);
>     if (r)
>     - return r;
>     + goto err_release_full_gpu;
>     }
>     switch (adev->asic_type) {
>     @@ -2012,7 +2012,7 @@ static int amdgpu_device_ip_early_init(struct
>     amdgpu_device adev)
>     adev->family = AMDGPU_FAMILY_SI;
>     r = si_set_ip_blocks(adev);
>     if (r)
>     - return r;
>     + goto err_release_full_gpu;
>     break;
>     #endif
>     #ifdef CONFIG_DRM_AMDGPU_CIK
>     @@ -2028,7 +2028,7 @@ static int amdgpu_device_ip_early_init(struct
>     amdgpu_device adev)
>     r = cik_set_ip_blocks(adev);
>     if (r)
>     - return r;
>     + goto err_release_full_gpu;
>     break;
>     #endif
>     case CHIP_TOPAZ:
>     @@ -2047,13 +2047,13 @@ static int
>     amdgpu_device_ip_early_init(struct amdgpu_device adev)
>     r = vi_set_ip_blocks(adev);
>     if (r)
>     - return r;
>     + goto err_release_full_gpu;
>     break;
>     default:
>     r = amdgpu_discovery_set_ip_blocks(adev);
>     if (r) {
>     adev->num_ip_blocks = 0;
>     - return r;
>     + goto err_release_full_gpu;
>     }
>     break;
>     }
>     @@ -2062,7 +2062,8 @@ static int amdgpu_device_ip_early_init(struct
>     amdgpu_device adev)
>     if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
>     !amdgpu_device_get_rev_id(adev)) {
>     dev_err(adev->dev, "Unsupported A0 hardware
>     ");
>     - return -ENODEV; /* device unsupported - no device error /
>     + r = -ENODEV; /* device unsupported - no device error /
>     + goto err_release_full_gpu;
>     }
>     if (amdgpu_has_atpx() &&
>     @@ -2123,7 +2124,7 @@ static int amdgpu_device_ip_early_init(struct
>     amdgpu_device adev)
>     if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
>     r = amdgpu_device_parse_gpu_info_fw(adev);
>     if (r)
>     - return r;
>     + goto err_release_full_gpu;
>     bios_flags = amdgpu_device_get_vbios_flags(adev);
>     skip_bios = !!(bios_flags & AMDGPU_VBIOS_SKIP);
>     @@ -2131,8 +2132,10 @@ static int amdgpu_device_ip_early_init(struct
>     amdgpu_device adev)
>     if (!skip_bios) {
>     bool optional =
>     !!(bios_flags & AMDGPU_VBIOS_OPTIONAL);
>     - if (!amdgpu_get_bios(adev) && !optional)
>     - return -EINVAL;
>     + if (!amdgpu_get_bios(adev) && !optional) {
>     + r = -EINVAL;
>     + goto err_release_full_gpu;
>     + }
>     if (optional && !adev->bios)
>     dev_info(
>     @@ -2148,7 +2151,7 @@ static int amdgpu_device_ip_early_init(struct
>     amdgpu_device adev)
>     adev,
>     AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL,
>     0, 0);
>     - return r;
>     + goto err_release_full_gpu;
>     }
>     }
>     }
>     @@ -2159,14 +2162,16 @@ static int
>     amdgpu_device_ip_early_init(struct amdgpu_device adev)
>     }
>     }
>     - if (!total)
>     - return -ENODEV;
>     + if (!total) {
>     + r = -ENODEV;
>     + goto err_release_full_gpu;
>     + }
>     /* Request full GPU access only for the remaining SR-IOV init work. /
>     if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
>     r = amdgpu_virt_request_full_gpu(adev, true);
>     if (r)
>     - return r;
>     + goto err_release_full_gpu;
>     }
>     if (adev->gmc.xgmi.supported)
>     @@ -2184,6 +2189,22 @@ static int amdgpu_device_ip_early_init(struct
>     amdgpu_device adev)
>     amdgpu_smu_early_init(adev);
>     return 0;
>     +
>     +err_release_full_gpu:
>     + /*
>     + * Release the exclusive access acquired above so the host
>     completes the
>     + * handshake instead of timing out and FLR'ing the VF.
>     + /
>     + if (amdgpu_sriov_vf(adev) && early_full_gpu_access)
>     + amdgpu_virt_release_full_gpu(adev, true);
>     +
>     + /* Don't send request since VF is inactive. /
>     + if (amdgpu_sriov_vf(adev)) {
>     + adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
>     + adev->virt.ops = NULL;
>     + }
> 
> I think this is not the right place for this. These flags are not set
> inside this function.
> 
> Chenglei:
> Agree. I'll move the release + deactivate into a helper in amdgpu_virt.c 
> and just call that helper instead.
> As this is needed to avoid REQ_GPU_FINI timeout post release.
> 

Yes, that works.

>     +
>     + return r;
>     }
>     static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device adev)
>     diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/
>     drm/amd/amdgpu/gmc_v12_0.c
>     index cd276a138e10..5c6a20e42000 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>     @@ -667,8 +667,15 @@ static int gmc_v12_0_early_init(struct
>     amdgpu_ip_block ip_block)
>     r = amdgpu_acpi_find_gpu_memory_in_srat(adev, &aper_base,
>     &aper_size);
>     - if (r)
>     - return r;
>     + if (r) {
>     + /*
>     + * An SPM VF has no FB BAR0; without the HBM aperture
>     + * from the SRAT this GPU cannot init, so fail its probe.
>     + /
>     + dev_err(adev->dev,
>     + "SPM VF: no HBM aperture in SRAT (%d)
>     ", r);
>     + return -ENODEV;
>     + }
> 
> amdgpu_acpi_find_gpu_memory_in_srat has error logging. The error code
> returned is -ENOENT when table is not found. So this change is not requred.
> Thanks,
> Lijo
> 
> Chenglei:
> I will drop the redundant error log. But I would like to keep the - 
> ENOENT to -ENODEV change.
> The early_init loop treats -ENOENT as the IP block being absent and sets 
> status.valid to false,
> so the -ENOENT makes the init continue without GMC and only fail later 
> with -ENOMEM.

Thanks, I see that now.

gmc is one critical block. I think we should later decide not to proceed 
if any critical ip block fails.

Thanks,
Lijo


> -ENODEV sets total to false, so it aborts at the real failure point. Let 
> me know if you would still prefer
> to drop this part.
> 
>     adev->gmc.aper_base = aper_base;
>     adev->gmc.aper_size = aper_size;
> 
> 
> ------------------------------------------------------------------------
> *From:* Lazar, Lijo <Lijo.Lazar@amd.com>
> *Sent:* Thursday, October 29, 2026 12:43 AM
> *To:* Xie, Chenglei <Chenglei.Xie@amd.com>; amd- 
> gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Luo, Zhigang <Zhigang.Luo@amd.com>
> *Subject:* Re: [PATCH 2/2] drm/amdgpu: abort SPM VF init when the HBM 
> aperture is missing
> 
> 
> On 22-Oct-26 9:01 PM, Chenglei Xie wrote:
>> An SPM-backed SR-IOV VF has no usable FB BAR, so gmc_v12_0_early_init()
>> resolves the VF HBM aperture from the SRAT. When that lookup fails the
>> code returned -ENOENT, which the early init loop treats as the GMC block
>> being absent. The probe then keeps going without a memory controller and
>> only dies much later with -ENOMEM, far from the real cause.
>> 
>> Return -ENODEV instead so the early init loop aborts this GPU probe at the
>> point it actually failed. Other GPUs probe independently and are not
>> affected.
>> 
>> Aborting here also exposes a second problem. On a legacy host the VF takes
>> exclusive GPU access at the start of early init, and every error path
>> returned directly without giving it back. The host then waited for a
>> release that never came, timed out, and recovered the VF with an FLR.
>> Route the post-acquisition failures through a common err_release_full_gpu
>> label that releases full GPU access before returning.
>> 
>> early init also fails before the CP scheduler is programmed, so the host
>> treats the VF as not active once it sees the release. Clear
>> AMDGPU_SRIOV_CAPS_RUNTIME and drop adev->virt.ops at the same label so the
>> later fini path does not send a REQ_GPU_FINI that the host will never
>> answer.
>> 
>> Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 ++++++++++++++++------
>>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     | 11 ++++-
>>   2 files changed, 43 insertions(+), 15 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 5069042b5279..10002b78c69d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -1999,7 +1999,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>   
>>                r = amdgpu_virt_init_critical_region(adev);
>>                if (r)
>> -                     return r;
>> +                     goto err_release_full_gpu;
>>        }
>>   
>>        switch (adev->asic_type) {
>> @@ -2012,7 +2012,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>                adev->family = AMDGPU_FAMILY_SI;
>>                r = si_set_ip_blocks(adev);
>>                if (r)
>> -                     return r;
>> +                     goto err_release_full_gpu;
>>                break;
>>   #endif
>>   #ifdef CONFIG_DRM_AMDGPU_CIK
>> @@ -2028,7 +2028,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>   
>>                r = cik_set_ip_blocks(adev);
>>                if (r)
>> -                     return r;
>> +                     goto err_release_full_gpu;
>>                break;
>>   #endif
>>        case CHIP_TOPAZ:
>> @@ -2047,13 +2047,13 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>   
>>                r = vi_set_ip_blocks(adev);
>>                if (r)
>> -                     return r;
>> +                     goto err_release_full_gpu;
>>                break;
>>        default:
>>                r = amdgpu_discovery_set_ip_blocks(adev);
>>                if (r) {
>>                        adev->num_ip_blocks = 0;
>> -                     return r;
>> +                     goto err_release_full_gpu;
>>                }
>>                break;
>>        }
>> @@ -2062,7 +2062,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>        if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
>>            !amdgpu_device_get_rev_id(adev)) {
>>                dev_err(adev->dev, "Unsupported A0 hardware\n");
>> -             return -ENODEV; /* device unsupported - no device error */
>> +             r = -ENODEV;    /* device unsupported - no device error */
>> +             goto err_release_full_gpu;
>>        }
>>   
>>        if (amdgpu_has_atpx() &&
>> @@ -2123,7 +2124,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>                if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
>>                        r = amdgpu_device_parse_gpu_info_fw(adev);
>>                        if (r)
>> -                             return r;
>> +                             goto err_release_full_gpu;
>>   
>>                        bios_flags = amdgpu_device_get_vbios_flags(adev);
>>                        skip_bios = !!(bios_flags & AMDGPU_VBIOS_SKIP);
>> @@ -2131,8 +2132,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>                        if (!skip_bios) {
>>                                bool optional =
>>                                        !!(bios_flags & AMDGPU_VBIOS_OPTIONAL);
>> -                             if (!amdgpu_get_bios(adev) && !optional)
>> -                                     return -EINVAL;
>> +                             if (!amdgpu_get_bios(adev) && !optional) {
>> +                                     r = -EINVAL;
>> +                                     goto err_release_full_gpu;
>> +                             }
>>   
>>                                if (optional && !adev->bios)
>>                                        dev_info(
>> @@ -2148,7 +2151,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>                                                        adev,
>>                                                        AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL,
>>                                                        0, 0);
>> -                                             return r;
>> +                                             goto err_release_full_gpu;
>>                                        }
>>                                }
>>                        }
>> @@ -2159,14 +2162,16 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>   
>>                }
>>        }
>> -     if (!total)
>> -             return -ENODEV;
>> +     if (!total) {
>> +             r = -ENODEV;
>> +             goto err_release_full_gpu;
>> +     }
>>   
>>        /* Request full GPU access only for the remaining SR-IOV init work. */
>>        if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
>>                r = amdgpu_virt_request_full_gpu(adev, true);
>>                if (r)
>> -                     return r;
>> +                     goto err_release_full_gpu;
>>        }
>>   
>>        if (adev->gmc.xgmi.supported)
>> @@ -2184,6 +2189,22 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>        amdgpu_smu_early_init(adev);
>>   
>>        return 0;
>> +
>> +err_release_full_gpu:
>> +     /*
>> +      * Release the exclusive access acquired above so the host completes the
>> +      * handshake instead of timing out and FLR'ing the VF.
>> +      */
>> +     if (amdgpu_sriov_vf(adev) && early_full_gpu_access)
>> +             amdgpu_virt_release_full_gpu(adev, true);
>> +
>> +     /* Don't send request since VF is inactive. */
>> +     if (amdgpu_sriov_vf(adev)) {
>> +             adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
>> +             adev->virt.ops = NULL;
>> +     }
> 
> I think this is not the right place for this. These flags are not set
> inside this function.
> 
>> +
>> +     return r;
>>   }
>>   
>>   static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> index cd276a138e10..5c6a20e42000 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> @@ -667,8 +667,15 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
>>   
>>                r = amdgpu_acpi_find_gpu_memory_in_srat(adev, &aper_base,
>>                                                        &aper_size);
>> -             if (r)
>> -                     return r;
>> +             if (r) {
>> +                     /*
>> +                      * An SPM VF has no FB BAR0; without the HBM aperture
>> +                      * from the SRAT this GPU cannot init, so fail its probe.
>> +                      */
>> +                     dev_err(adev->dev,
>> +                             "SPM VF: no HBM aperture in SRAT (%d)\n", r);
>> +                     return -ENODEV;
>> +             }
> 
> amdgpu_acpi_find_gpu_memory_in_srat has error logging. The error code
> returned is -ENOENT when table is not found. So this change is not requred.
> 
> Thanks,
> Lijo
> 
>>   
>>                adev->gmc.aper_base = aper_base;
>>                adev->gmc.aper_size = aper_size;
> 


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177D4C64EC7
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Mar 2023 02:47:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B586010E095;
	Wed,  1 Mar 2023 02:47:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69DD210E095
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Mar 2023 02:47:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoVgFmQBxqmAu4KDPhz6Wi+Dp+xIl/uUULhTeIsczDuhiPl7PoQOf4PU39pDjLnnpGCy0vlgb3RcgI7v7FTJmh/9WSAUtUhPi2nbmXQkTAWxerwjuaIswzv/KBijnt1cB3FhU9Zkw9ntj1an+4HdkJ2fiNmVtIg8143fBbvzoagxyOiP+poDaDtU87M2avWZkgfU8ApTNUCa/x6s/ISvBCUUjyi16YJ5bnpugnz1Ar1hAB53YVMe71QnqoSthDaOUwyHg5zCLnUcf2GnKq/PitocNaZjdmaaeqohKP62wyG9GGDqgVxLVXf6RVv016hk3J1BQbYIgqHTISYPmOoTjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tvx3sUrptibEmtvb87GzydXEkSex2lpCbpNes9MkWE8=;
 b=Bbsmnfa4B2BfsZHHDJJjDS28EURHBE2zQAlSdzE4kmfzdQcXSxN9C9O8KFP0Q4n9E0o57JXi0ASW7mEFwE9oMNOtmG4Myllr68nejzmgpC+DmTZiranRnH+o/hsLGpVMiwxIlJQHNmBSiaLwhICJvovlyY6DkOCq+PnVnmGCkUAbQpV6nnfvpzNHfIWN1dza9XmUc4QVkxF5zwFhVMOvuMjRvoINTZOplSluqq25SrmtKpoL6FLZs4XebD8h3I8sFxittFIFOsAmVEsC5ljWuoXVd7l2WXu1e3ILRIbSYj/pkNBiDp78DV/9GEHv8byfRLdtyiXR5+0Ek2r17pl72w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tvx3sUrptibEmtvb87GzydXEkSex2lpCbpNes9MkWE8=;
 b=1GljSoF8Coc1zBWkYuvNOiPVEzBx8vjLQzSINIxB4Xrv110vQc+01Msnck+yKip7L22RBspmAWMFJU5FfP2RWAc/XqqH3SdmVROtyGwevp0NFFbixlb+bMIS0j8i/C8Gi8ZvidmKHAKKwEi1HE7IJNeCVSH4mwsnDIREvvbMSZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (2603:10b6:208:16e::22)
 by IA1PR12MB6578.namprd12.prod.outlook.com (2603:10b6:208:3a2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Wed, 1 Mar
 2023 02:47:30 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::df06:d3ad:cd5:e1c9]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::df06:d3ad:cd5:e1c9%6]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 02:47:30 +0000
Message-ID: <e25d9208-b3ec-826c-ec77-e3d4443b9c15@amd.com>
Date: Wed, 1 Mar 2023 10:47:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: Stop clearing kiq position during fini
Content-Language: en-US
To: Yaoyao Lei <yaoyao.lei@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230227064530.2699469-1-yaoyao.lei@amd.com>
From: "Yin, ZhenGuo (Chris)" <zhengyin@amd.com>
In-Reply-To: <20230227064530.2699469-1-yaoyao.lei@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::13)
 To MN2PR12MB3663.namprd12.prod.outlook.com
 (2603:10b6:208:16e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3663:EE_|IA1PR12MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: 9087b2b0-f682-49ee-85f0-08db19ff4c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nSrH2+yJh5aKoMOBWBNToNSdo+Wz4yOIktczNr6kJer/cWSEgIRIaIs7GkopKGdevVzrsTXya3GhPOi3hxr8ZLFzPKEYCjsM5kqURgI5iuWkvDzLDVOt+3sEh8lLOFNm0vKlGby231HADWwZF7nVnJUp/SoJv9jCuyFLRn5Y8+rp1VEGAfr9CRPHWuUYd85CtXYhxGualfBX42+iw7x4LupM6pVu1J7dWUPKcHtbTFxzvSxMnzZUvflDgXxLsAOYDq/TsYfiJuUfP3ztukAic6Tv9GX6Ozb2Qfwgb9mjWpe0n0PvXcyLdtR0WER3eqSagnCnvFTpBl+Jo+5pvN/lXb/jkLWV8684/92MrVcRhINqKv65kB4svPrQlUHSPJw1LjqrZOm3kqnmUAGIbZyS5ceQuPj8Skbjjhuyfygz5p2VOtVmFcKDKUTZcvfn8b6WW6+/bsjt4GXxjSijIcLkqzFgkznj/tqhV0vYkeiCCSE0Ss4u7I3EcUCQsZxKBEosjSQwCv4GeaZqbfH4iJrOjKH42H3U4IbfP4RkBWr8JMsoohB6bZrHctljP5ehZ4N4W8ZfjyALqIeaeS1wDXjo+d2u1PfKEPOt4GKbw1pf0BPWjbV0PpEpCsdXgR5u9FM8ju4JDd3M1qdOaEvB3Geplm+sx+IQRdoxRfwOjIOXzxSw0KnhL/40Fm1hHzQr3rPi6Nk3+lCkdyaDz78KTqRqCoonP0JeOSJUWG+iJGZJoe4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3663.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199018)(8936002)(5660300002)(31686004)(2906002)(66946007)(66556008)(66476007)(8676002)(316002)(478600001)(41300700001)(6486002)(6512007)(6506007)(53546011)(186003)(6666004)(26005)(2616005)(31696002)(36756003)(83380400001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFIzc3ZabTRBbStSRHJ1ODZlTkU3NXVzTmhNRVJVNTRQcE0xK0J4SUtSS0Vu?=
 =?utf-8?B?TUhrVm1lVFdjQTQwd0dJVWQ0QlByU0FTUFV0dEZ1d0JiTGxkMm5LZkdrL3c1?=
 =?utf-8?B?Z2pRYW5nUmF6dWtsNjhJc1NidWhCak1QWmV4dEZLVE1ueWpiTFNMZ29xVEEz?=
 =?utf-8?B?VFhpa3d0SkVIOWd0VTNKOStyNTFNWDN1dXg2YThRRmcxUW9RaGNEU1FWQ0ds?=
 =?utf-8?B?TThFeEFENjhUSWhYTThYV25VY05KS2JwUlJaa0N5SkhESlZjY0NqM2FMV1d4?=
 =?utf-8?B?MFNhellaeDZpeGhBYmdjRnBGOTkrR2daenJ4bENCbzRMdi9aR1ZMcDhmU1Ix?=
 =?utf-8?B?WXAvUFpJQ2hZQ3BQdmJ3S3NVYkxLUEpBeGUySitEQ3dROWhyaE5NTUJBZFFz?=
 =?utf-8?B?anVGU1kycFZyZENEWlhydWtPTUZNZWdQc0h6dVQ4aUliTzNVTytvQy9rK0pJ?=
 =?utf-8?B?aWRaOGxCU1dyS005cExlMFBiRVBaZlVDZ3paUko4dDd1TDljQ2pObGxWc1Z3?=
 =?utf-8?B?YnA5MGM2cnBnMDZsclRFbXJDdWxvSFlvVGQrTWJ2emY3Vm1veUxaYWh1Z3Ez?=
 =?utf-8?B?WllJVk1CcGxOUktFTlNhUUhvODhORVV1djREOEVEYndITG82aXIwOFdXTmVp?=
 =?utf-8?B?OEJWbVM5M1kxM0s4emlpREdjRkorMmdZQ3FyUGxTNGdWYjJZc1RPZ1duM0Zs?=
 =?utf-8?B?czN3RXIwNlBLbHAyS2p5VEpISTdCMXp5bVF5UlVnZ2RaVDlDajVodWJMV1FF?=
 =?utf-8?B?RTA3SUhoaXl1QmJFMW9Ub21DTGJIRTE3NTI0aWlSWW5zSFQ0bXN5eVZOV1FD?=
 =?utf-8?B?MDAyekFoT0lNbHlXR0dJSDRYSy9sVUZHa3A5d0x0NUJUUWNIWUNOanVXaW5p?=
 =?utf-8?B?MFV3Q3A3NlVWT2NWSU9oSXQveHQvTDNmdTcra25IekNKcXZsSVVkeFoybEVP?=
 =?utf-8?B?Y0RXb2pwc0d0aWYxU0pSM3hTV05sQm1HL1Fad243NHFobTdSZnZud2VBeEYv?=
 =?utf-8?B?aDNMRXVWa1dNa1hubGpzdys1dmU2bGNTZURaT1Z4Tm4yOVBYMmJWYlkvQ3JE?=
 =?utf-8?B?Tmh0aTVSbVU1bXVrcFI1M3d4c3dWYkhXcEZFdmlYYzI3cUpqdGdUY2hCRHFH?=
 =?utf-8?B?ZURZR2tyZGk3bGIrems2U0pNQlpzVURZbmFJTTVYR3U4MEtPTWpDZld4a1dt?=
 =?utf-8?B?U2xXdEVoVVRKYUpCM01ZaDNlVDFmem1HZUtvZGl3Uy9sYjBHRjVOUkErWXUr?=
 =?utf-8?B?Q2NFUmtmbnlyT2pERllZN1RiNm5FZkFLd1QxalhZUHlxak1nL05FOW9tSWVt?=
 =?utf-8?B?bVQvckRyOHZGaXFJRy9Za2w1d2JYK0ZrTE9ObERLZ2hEL2FZTXZpRmlpSGpo?=
 =?utf-8?B?SzBGQnpVUC8xb2NzbFIxR0tOM2xhZXd5RlN3MitnbEY1SlhwVmxxdWxaN25a?=
 =?utf-8?B?TXNQd1NFR21lVWRuNXcvL1RZWDNxMlNQNmtVa05FM2x3TUZoUDJ6TXFUVUJS?=
 =?utf-8?B?aGs2KzdXQVI2UDczZXBZVVhZc1FzRjNWLzdZaVBDdkEyc2k5cnBnenJFQmVh?=
 =?utf-8?B?VmxOeEw3VVM1UzB4ZFFkMUlrTHNNZ1MyOGRBdVFpYng4ckVHWnkxQkE5SEw3?=
 =?utf-8?B?YVRTNktqVXNuUGNEY1JZWnQ4d25ZbkM2cXM2YUViS2JJN2NaUDVqYnF6RXZ1?=
 =?utf-8?B?ckJXd2JrTk9LVzJKaHR0SS9JSXJOS0x0M2J2UHpsWDRrSjg2WG1BcXlTM0xh?=
 =?utf-8?B?TnAzSnc0MFM3U2lxZmpteWlpRlVxTHB3M0IwckZWWmFucG9VNWF1aUpyUk1l?=
 =?utf-8?B?d2pWaVJzVkoxZlhuMGc0SVV4aGU4d0ZNYjZmWlVDVW1RYTJGbGJJUWlDZ2ti?=
 =?utf-8?B?OHRVRXF1YWN4eDl0OVpRVWlydXRqaTVKRVJDQW81NmNKd08rMi9DRG5RWStk?=
 =?utf-8?B?RXFqNDVDN0ZjLzE1ZW12MXFtN1RCVHpndy91anZ3YUtYS09SMittQU9ETHNU?=
 =?utf-8?B?b3RBU2RNNm84WnJwWkpHd3h0VEl6VlVwWTZtWFRDcVUveEF6THIxd2pMbzNi?=
 =?utf-8?B?Q2RTTmZIakVVYTdUYWVTazZtczk3UktacGd2S2orTzBXTVZjZ2U4Zm4xUFVO?=
 =?utf-8?Q?lumsKCqUJSyn0yA6Vjk3X3Eym?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9087b2b0-f682-49ee-85f0-08db19ff4c6e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 02:47:29.9285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1ew8wddODIrEpl7WEzLszc1MRUOrhBY1rPiEwzCeLERTnY33So7IhP0kr8KlnZ6EYK6x+J2QfmbWVdpYmF6Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6578
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

Acked-by: ZhenGuo Yin <zhenguo.yin@amd.com>

On 2/27/2023 2:45 PM, Yaoyao Lei wrote:
> Do not clear kiq position in RLC_CP_SCHEDULER so that CP could perform
> IDLE-SAVE after VF fini.
> Otherwise it could cause GFX hang if another Win guest is rendering.
>
> Signed-off-by: Yaoyao Lei <yaoyao.lei@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 14 +++-----------
>   1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 6983acc456b2..073f5f23bc3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7285,17 +7285,9 @@ static int gfx_v10_0_hw_fini(void *handle)
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		gfx_v10_0_cp_gfx_enable(adev, false);
> -		/* Program KIQ position of RLC_CP_SCHEDULERS during destroy */
> -		if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 3, 0)) {
> -			tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid);
> -			tmp &= 0xffffff00;
> -			WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp);
> -		} else {
> -			tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
> -			tmp &= 0xffffff00;
> -			WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
> -		}
> -
> +		/* Remove the steps of clearing KIQ position.
> +		 * It causes GFX hang when another Win guest is rendering.
> +		 */
>   		return 0;
>   	}
>   	gfx_v10_0_cp_enable(adev, false);

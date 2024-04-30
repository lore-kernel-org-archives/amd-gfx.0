Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35405C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 13:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB7A210EA4B;
	Tue, 30 Apr 2024 13:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PJBavfg9";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 476CD10EA4B
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 13:36:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvrRc03k3WsW8U/3CuQMLUPt8YTPllc+xBY3aUjbGYtb6KUmYoNgo3ziIP+QpcrAtSrrBLf/bDHtkW2cOC1B1Rz+292fUjI5qABUHnGibaaX+spKSQ8a557uh9QHUXzy7T9VLkOUXYaA4eyxLCNNlIy3tHiu43u0w7KLl+8JOE41O8FCVkAAelWNVPa9XVILQvnLlfYVQjZ1SBruV8mG75lH0T4xEcfhtMQE9eXGQCXKKmrKbTJnX6DTyEo3g1fTkdK6TuJigEUxgyDEDi/QoWrAfKcPlHEqXxEsvwPz6wrII4yLXHVFdyuE5l58qvjScR3bzZcwJXAv5lP0kF9Rig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3A7ESFtgjRX4yVwEWLOKNPt8p751Q8H6hirJXyZodU=;
 b=etcMtTWmB8Ibfa0fNlQ+7ciPn6MhuZndpfwBijD1Y+QauUjHVvLE/+lmh8485n/kLyV0/nU6tkniXnfAynrpguXqbgCII7OIU+tTzFZPjcCUnos7a9IXegiYltdUVtoZPuM+T0NlLCAuRUW+otbyn6oO1Ke8KaGxSoexREPihzR6rpPD9JYqJdhbICya5m0OwQ5vZOo1axEeTB7h3TI2Y6+73ImKRgcOoB9ydcbzvK+OlhFeBU/guirZNB+UZhJqhtbJXFnvWlusZCCPZb/ykkivv3KtfMSimIslM/Yf9kNz+zZvodHBBG+ZccT5Oc2nTqjm5KplEswGzc+b5hje3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3A7ESFtgjRX4yVwEWLOKNPt8p751Q8H6hirJXyZodU=;
 b=PJBavfg9OE4MSIF3442MA1z7uG+mpZesKRgJv0KiSvakztra34to/Kv8bV3C6ugIDPIM+7j+0BVhWjPL3t2MwUy3s9D+wKRw44u/03/RBSbmXrHUWaR8yeoe6abyJCLEqsqgbQf50hoCjEHYgEenV6SN5lCHQ5VEQpGCuQnTR8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 13:36:35 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 13:36:35 +0000
Message-ID: <1802b351-261d-4b85-bd19-cf5cb81ca8bc@amd.com>
Date: Tue, 30 Apr 2024 09:36:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Override DCN410 IP version
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: rodrigo.siqueira@amd.com, alexander.deucher@amd.com
References: <20240430132340.16902-1-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240430132340.16902-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0046.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::28) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: a69fa844-889a-48fa-005a-08dc691a8dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mm13bEROTTdQRmo1UGdmT3BFYk1EaW15MzFUUHk3RUNzd0x3VERjYmJjcnNL?=
 =?utf-8?B?VDFoU1J2RllxZ1dPOHhkOXViS3hWRkt6bklQM3hvcUN1c0RVSU05L2FBYXVM?=
 =?utf-8?B?S2RvRExwUGNzSGp6TzBjcEFTblFMdXVZVmk5djF3K3ZqMHhKL3RFNUF4dmxv?=
 =?utf-8?B?ZkxwRVY5WG9jeDFzc2pYa1lYQzFvQTRIcVNYdXRQR1gvaHNXS0JjQkNRbVpN?=
 =?utf-8?B?OXBpdjlpZllMbFJ0QzZLWXcrSTE5MjZobW1uK0FQTjluVW5NRjRzU3F0Z3FM?=
 =?utf-8?B?U1VDaGMzZWtVL3NJNGgyR1lWMUx6ajN0RFRJbXRwK0ZBclk3UHdlbmQ2WGtx?=
 =?utf-8?B?K2h0d3NmbmtNNDBQNlZGSXhYazZ6RFdoKzV1QTNhTEN5YlYvQkxBZ0JxZ0U4?=
 =?utf-8?B?djJiWE5nRDU1dmxFUm5wSE1jQ1hGSVZreitDVW11eW0vVjhONVB1OGFGY0NW?=
 =?utf-8?B?eng1TGJwVFRFdGMyditXU3RzMGloeG94NFNoTlBnL1JNUVVUSnpRcGJxYWpv?=
 =?utf-8?B?cFk1N0ZaajFaaWJsM1ppRm9IYU94ZFQreENoM3U1Z1pWNDlWbERZTklFcy8w?=
 =?utf-8?B?eGJnb2ltOUxxVWVYOEJvWXZrMW9qMG1PY21YRFpKTFNtT3VDN1IwN2lZZzM5?=
 =?utf-8?B?L2s0Z0s2QTRHUDM5ek9YUXhTaStkR2Y2UFcxRkQxQm5wbmk4VTh6YWJiZ21W?=
 =?utf-8?B?MUIvaUdwTEVub3Vxa0NaU0IxRDlERSsrVDFTY29LSXU4Y1dyU0JtbmRwc0wy?=
 =?utf-8?B?RDFySDQwMldKV0tVOVpJd2xVUnVBZ3lmRDJCeVk2eEtnN0R6aHMxcDk0T3BG?=
 =?utf-8?B?eFRlNUhJYkY2N0l1VFdoTXJDVU1wbkVydzFUYUY1djFiY0FjTGpaRlJMQm9K?=
 =?utf-8?B?elJMekhuNm5uVzdpZ3QwQnZqU2cydTJqL0FoUWtHc1I3VG43VUJYVUYvWitX?=
 =?utf-8?B?UWtDNGs2cUVUQ09sTHBaWmNzckNJRkJ1WUtIL0FaMEhZMnAyblZwSUNWTTVG?=
 =?utf-8?B?MEJTK3FWR0JiSlJQU3RWQ2xSdWRlbmx3UlBhd0crT2dsNE0xdjZjOUpkaDQw?=
 =?utf-8?B?aEFqN3JMNWZPalpFbXplSkEwQmVlN1BlYTZJS0x5UnNyZit2QmVUMjNOVGNU?=
 =?utf-8?B?aVpQNTA1T0lUdkZqanRJcFZzTGJTbXpUazNJL29ja0dlTHl5R0loN0c1OXpD?=
 =?utf-8?B?N0d2aWMySG9LZVNhSEIyVWVOdkVtYndrMDFzUXFFT20vTzB0VlN2ajgvZTBH?=
 =?utf-8?B?MzJ3S1kxSVJBVlZ4UTNSRXRjL2MrNU1qaVZCS3J0Sm9MK2xUbFFyV2kybXFy?=
 =?utf-8?B?dkNCeDVLemMrWU9QdHE3U0N2VGk4MUJyWHEvVmZSZnFlbGR3ZUZ2V1Badmlu?=
 =?utf-8?B?ckxPV1JEL0hwa0N1a25qYytIK0NkclFQd0ppZVdoOHR2UE8vTlNJRXc1YzBv?=
 =?utf-8?B?WTc2N2Vya0ZyV3NkWUx2TG9VV2g0UUdNU24reUg1K0UwcitUcXNIMHdQb05j?=
 =?utf-8?B?T3ZnL0dlU01zZlZWZ1RxaWthMzJJYUo2bHByVDBtVG1PdUJKRFpHMWlZcjdY?=
 =?utf-8?B?UlNadW8raC9yUkFMVFR0Rld5R093Q0YyQzZxQkVVSTVFR2hMNWQ0dXFiSjdj?=
 =?utf-8?B?bDlRT2xkM0tUcUo1UFV0VEllaXdVdUxmcTcxVDQ2QXcwMzhKYkI1dWpTSnV3?=
 =?utf-8?B?endKWVhSUGpBdEltSDliN2RiN3FiZko3L0hoMjNIdWhYdjVLMGhSaThBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czgreHd1Wkg5dDJ4ZzJSaUpwY3padnNtdElKSVJaUHpTelhYeWZaQmh3Vm5J?=
 =?utf-8?B?SnpDc2w2aGpMZWJLS2VHempZRXgzTEtMV3MxZFBXRzU5am1CSjlKWUNjUEFO?=
 =?utf-8?B?Q1psb0FNMXZZZnpndXNYMVBxZG9kWjU3NW5JWVpCMUJYdTNZN0FmSEdTTG1K?=
 =?utf-8?B?R1poUHVmZ2wwNFl0TysyVThnNTByS0M2Z0RCdjdJZEJhVFRzNlBZcFpxWDZP?=
 =?utf-8?B?b1IyVTBCeGJYRVNydU9nVTFrMzdaODZ1aVVtcm9vNHNuY2ZqTW5wSWF5aUY2?=
 =?utf-8?B?dFAvWTl5ZHhvb2N2WEtsNVIxVnQ1VzROcTJQS2g0Q0JrVi9mK0g1U1IzRExO?=
 =?utf-8?B?NW53VDluRC9lMi9abTkvUE40aEo1d1RibUI2Z0Zld2w0cmRhZmIyK1RDajVp?=
 =?utf-8?B?SWtnUEhqZFZYSXozUWJOT1dBZmlEU1VDTlVQZ29RV0k4L1FXcEx1TzNWMXVR?=
 =?utf-8?B?bG1HaHRIMjJSYVZtRVZBQTlKOXpSNGFTdXdzbnpYbmcrcFA2eTk4RHVGMWtQ?=
 =?utf-8?B?b014bUhmdzFwQjlFdnRPbmcrcXRMZ0g4TXZiOXBCTFVKNGxYcVFDa0hHYkF4?=
 =?utf-8?B?cVVjUU0xajlvblRJcktySFV0cHFIdEhXSTA4TkZlbXQzTzQwU1pZQnVFdFp1?=
 =?utf-8?B?V3k0Ui9rYmVYWDJwSFNKM1I5N2ZSNVlPNUNiRDA4ZlhPdkNET1B0aGlRemE3?=
 =?utf-8?B?V1dIUUFPK0pkMVhnUXJXRkxxN0hlWUQvc1NHLzlNR0dqQXdLMW5KVHpvanJW?=
 =?utf-8?B?RWJJRzJIZXo5a3hCQTZYNm9NZnRiQzVCNUpvOFY3c2trRElHaWdWR0NZRWpi?=
 =?utf-8?B?WngwUGJ6cGZ4ZWtUUWtDZm1PTWVtRmlIays2Wk40WWZpSWxBeVFaQmF1a3Vq?=
 =?utf-8?B?cHgrdG5LcnF2dmppMXpkSWxuZnp3QVZGOFdMVzF2bkVaWGxNT2F0VG1TcFJC?=
 =?utf-8?B?dVRZNXRUUlY0MmtwQjUwQTZKS1NjTE8yQjJBVFBwVTcycEpZbWNBNEV5ODda?=
 =?utf-8?B?YTE2eEpTTld4TmZaQmZnUzBiSHNreUJBd2tHZFlPb3RQOEthL2w0WnBIbW9U?=
 =?utf-8?B?bDdrZ2NzZm4zOTUvcE12d2FDN2QxN0F4cnhDMGpOalRQOXhEbnJnQm9pcXd2?=
 =?utf-8?B?OTI0clEvMnRJTjdKWUhTY1JTbFZnTnJPRHJSN2g0S3ZTMk0zL24rUXNobHls?=
 =?utf-8?B?cDN2YTFTUWxQdXl3R1JhYkVablZ6T0NmSlFBZllmN211VlkxNGlqejlNdTV4?=
 =?utf-8?B?MXdZd0xYYURLOFBOWGJnUE1US1VWcWQrZWJ0cXFyWGxMbDgySHBMWnR4SExh?=
 =?utf-8?B?ZXBoNTRQQWFOc3djQ0VuVnZhOUxCZTdRc2pHV09WK29MdEd4dWVkTTBhdUZn?=
 =?utf-8?B?NjBFNVEyVFkxZU11MW1zRGdOd2J1b3hWWHhKVGFNVTNncWpXZ0lkSW5rVm1a?=
 =?utf-8?B?MlFDZGIxbDZUVVdoQ0hHb2dhMUdwU0RTc0lWUytvYmE5K21ZWjJyNFBiYTF0?=
 =?utf-8?B?SXZBQTgyQlIzOGh2VHRKemZPQmo1VTVRRU9yV3Q3UmtYeW42dVdNazF2MG9Z?=
 =?utf-8?B?cEFMa0JHSUFlMTVhWi9EcHV1SjlPYWpnbGJ2aitnU29qV3VsYitrL1VFSGtJ?=
 =?utf-8?B?bklDdFhWQmp6T0RwekxZS1Y3czd4dURiNVRxdXZsdUNuMDk4SjJLVUt0U29h?=
 =?utf-8?B?cU9lZWI0OWVlRG9Gb2Z2cE5DYjdGYWR1VjN5K2ZFaDdFSkRoMHB4WnowWitF?=
 =?utf-8?B?OEIxNTJmME5lSEtVUE1qL1R3RDVkU1R5dGZGbWtwRkJFS1lidDNleXNpcXpF?=
 =?utf-8?B?RDYrbTIyYWZJdjBaVW5pZDloMVVoRGhNUitUWkx1b1JVWkg3cysxNFVseUdB?=
 =?utf-8?B?bk5YVXgrdithSVZ0UXZ2ZGxOYi9MdzJTdFZaMExQZ3RuYjYyMDBqajZvN05M?=
 =?utf-8?B?R0ZyWkE2V1NTTXlGWmRWT3cvMmVDcGVjQi91WmFNME5rK1VrY1dqV3FqSGZI?=
 =?utf-8?B?MVRmM1lWTEN3Q2ROZ1FrV2NCTC96YjJqRERsdTl4ak05ZzBUM3M3b2RaM2pR?=
 =?utf-8?B?bUxldDlqbDdtTDV0cTFHNVRTNW93QSttNENjQ0M0a3NqQkxXblFFUm5ML0Nl?=
 =?utf-8?Q?mi7siPmwekmnKChha8fbXXvGP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69fa844-889a-48fa-005a-08dc691a8dd9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 13:36:35.1535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qw43XDr3xtoqLyFrwMojrtkgenRCc3Lbhk8lFAuWpeV8WtZV+Vae15vQMxT76s91Qarfp2AmOxXpcTexzHZZQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107
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



On 2024-04-30 09:23, Aurabindo Pillai wrote:
> Override DCN IP version to 4.0.1 from 4.1.0 temporarily until change is
> made in DC codebase to use 4.1.0
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 2aad1ba0ab9d..87a2f15c8a64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1965,6 +1965,11 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>  		case IP_VERSION(3, 2, 1):
>  		case IP_VERSION(3, 5, 0):
>  		case IP_VERSION(3, 5, 1):
> +		case IP_VERSION(4, 1, 0):

Doesn't this do more than override? Doesn't this enable IP
creation for DCN 4.1.0 in the first place?

It might make sense to split this into a separate patch
as it sounds like we'll want to revert the override at
some point in the future but not the IP creation.

Harry

> +			/* TODO: Fix IP version. DC code expects version 4.0.1 */
> +			if (adev->ip_versions[DCE_HWIP][0] == IP_VERSION(4, 1, 0))
> +                               adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 0, 1);
> +
>  			if (amdgpu_sriov_vf(adev))
>  				amdgpu_discovery_set_sriov_display(adev);
>  			else


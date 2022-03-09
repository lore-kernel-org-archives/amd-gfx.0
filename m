Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76AFC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Mar 2022 19:20:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24BE210E3F5;
	Wed,  9 Mar 2022 19:20:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD68E10E3F5
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Mar 2022 19:20:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwDBztRgEIFn+bHoj0vOQhDgjszH+jusqOTwBV4cUHqVlQ8SiDHDi4svQUh0kJ/BiYg76MlLMf3UN05EZILqLQVfPP08sZW+TsGLg9X2IwjHoB3IniRkFbwEgi7fE3j7wo42Z/sBLoBA7vG3Vdz3cAwZmGRAKtioOgjtfTyF8+NEfc3A+Tzg2WpNvkBpatvtk6I2fet2RQffq5XkgmOxmPCOUWMxXQ7eIWCJW3CpM7PTo9ds9lRWoFnq7YgHWQPr7plDRYJUkdTKBJX3CHmJExWya00LAaGvkjTLlkmosYunyAAgr461mSddyzw3bg70CZ30s2qTixFOYQFOLNW4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Oj0UiZbwRZvYen7wbFFJEVLCDiD3jAFLMgFDN4SB/w=;
 b=bAcElg5KlXxEET821m11+kvx1qBNS2jG/j4F2Ti4ZEeQyw1tuB/jp6aVuh7qbxDYTIXYkKd6MGFnHcrNRUtImxnAkxjKGEw5MUIr8oDwgptYbkW2RbTrGXZ3hNXNziZxR7j11AyrphJ/2FD81tLyXQUtSOA8E2N2O4dwOKEwNyJgliD9+kf+PqrNprBEoQ/oFczVY6PzQWDOzSBWrnCbZw9sgkcuXOgWfET3qYGWrzI0KTOJrhbwLIwFeCyRhQxthkhAA4QLbDo2aqcuYDdtTQnKv3ZwVLcKYuZ5w90qWGBRSxyN4bkpOmOz0XRDbHLTl4QU0z65qrWnO1JX64kRqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Oj0UiZbwRZvYen7wbFFJEVLCDiD3jAFLMgFDN4SB/w=;
 b=OhLIbphdiIA8EprTf392qf4VBhZuQdqV6IYt7gycxttM1q/gXIfMImrGCK2VPVSWpe6fwKtxBKi7Q/ZRuDqP49XdZu3OQs1mG8HeP1Q11fIj85/X4CBSVfw5N5bquZiRVbopD5/0gWAVJQlRag3XtrJC0VeAYxInwl26xJvWDQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by LV2PR12MB5821.namprd12.prod.outlook.com (2603:10b6:408:17a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 19:20:52 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::192:5346:4ece:7ca3]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::192:5346:4ece:7ca3%5]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 19:20:51 +0000
Message-ID: <8f94e08b-79ac-d214-cf2a-f4ff57895853@amd.com>
Date: Wed, 9 Mar 2022 14:20:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/amdgpu/display: enable scatter/gather display for DCN
 3.1.6
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220309185832.1324487-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220309185832.1324487-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0295.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::20) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d153b2e-2a70-4d93-eb5d-08da0201ebf9
X-MS-TrafficTypeDiagnostic: LV2PR12MB5821:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB5821586C485B1413F4D2B85C8C0A9@LV2PR12MB5821.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3UvUbPsQP6PQzjUC23w9PE1eUlvWtNCjN6a55B1gvSMlWZsC/xZmgcmru+IB86mWsqFrbwiyEWGnlUEc1NXaXlK0PKn1Rhorn7y0TtkEhba7h28XBxH9Kshw03kziW/NlFq3aaSlwYoUdO+Bl6gM6QNfTZvCRxppzlY092lZpXx8h7IyV5wZWCIjtQ5boPv4G9e1iv1hEPJQuhh5/T3SsZsjpFhrBcRWl2RxLuRHN9mlI2/ZPQaTqcaFTy1Hzmamcx3Bj877zOANmPPJ3iotyV5aU0PamlRvo6BsFC4Rz5Ohe5ZJ4k/NzgMCb/f7jbO2Ii9yKO7PhsC9PCWfWtjEdk10GRiIxYy5mu7tLVAzO2QrNQgiqtZMcb+FeuM3qvFcU7j6HUwDFeD6mkiSoM605irTL8Gb3AnkOMt5KMloasHYHqPrxf3W0npFa9Ol1S4zkKEO13wRzonWSU8Ni3lnmBy111gCDZELlcFXptlN3t/MGCrPdGjjE2iZ+NJnKNk0QZiKWg2QadBAxTbqOkq1giaJhDWDHT3Q0iRLRTHCZHP+JtSDFSL27Tu8GAICB4gcdczyzbqKd+Sito6Xv5iypyBLKFpapy6b2jogmoKgS1NDSHFxD7tnL000D142SGjF7doQbJz/Yv5mEcs/MeVCkCd61Ev+I92a9XanDVlV/P6II/wV5A0HTaLfHJzjkugxSWMJ5YinJAzvIewqH1L5+3MEEh/zjXqkH/ZYaS8Hq3XIoB98JimiyvWIdYZ/IOP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(508600001)(8936002)(2906002)(26005)(2616005)(31686004)(36756003)(6512007)(53546011)(38100700002)(316002)(4744005)(86362001)(44832011)(186003)(31696002)(6486002)(6666004)(8676002)(66476007)(66946007)(66556008)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnF3Y3lzNFpvU1RsK3RpeXhuTGF1Mnl6VFQrTWdRQVgrN2pNcXdlZUVHNkRZ?=
 =?utf-8?B?bnhHdWI1ZjVKQnNrZ0p4MSsxVngzTE9yZ1l3MGwzZk9SNzcrU0xLUmRiNTNN?=
 =?utf-8?B?Vk4rZnRVci9aSjBpd0FFc3E1LzRvTGZxdS93cnhUZG4zVWdtOS9VQVJvcUNY?=
 =?utf-8?B?cHk2eHVvZDhzODgzcXNHUXNENFJ5NnNpZndmT1ltUUhETTl4b2RtQVUvRTBl?=
 =?utf-8?B?NWtRY3hRMlIxaDUyOWNwL25nZE9ybSs1UjB2UGVFdHJ0SjZXRFpzMnhBTWIx?=
 =?utf-8?B?REJ5YWhtNW14c2VZM1Z6V1UyS1Z2M3dyeFFzMHV1MG1NbzcxaDhuZlZzTGdH?=
 =?utf-8?B?VGUra2lwVVhHS3pPUVV1eHJwQUlRQ3ltYlNZKzQ5VUIzc2ppdDlDdGdrUm9R?=
 =?utf-8?B?U3dxSnc5aXBad2RGWUNBbzhuVDhJR2k1aFYyZzhnbnQ4aUphb1RmVDhudkhH?=
 =?utf-8?B?dVhXcEVscmhaTG1zZnVYMVdIdS9RSWlPZ29NdDJVaXVyTU1ZeUVkMUk5dHNk?=
 =?utf-8?B?eWc3cjl2NERvZ3dOVmZpdDg5MVBObTIyQk92V2t4c2xiMnlDZlpCc25Gaklk?=
 =?utf-8?B?NWVkaTFneDVwUUdqU3ZzaEE1Y2M2bERnMmROMTBzOE9GbXlwQ1NqUHFmaDBi?=
 =?utf-8?B?cjdkQ2NpZmY1UGdkeUpSZ2FsV21FTVBwTFk3TW5RbWsrclE3RmZSamV2dG5u?=
 =?utf-8?B?ZVNKblpLRlNVVDlObDBDZ3lJejY5OHR5MGdWOGZFOFVRNkwrYU1zejk2alRC?=
 =?utf-8?B?QVJDajRjVmc5QUQ1dHZOTzYvZlZScXkwWWhya2MxaHdpR0ZBZ1VuQnZuT3li?=
 =?utf-8?B?aDBvRjVSM0laZ01jUFNzTVNhQ2M5TzNnbndiYlh4bzBZN2NJL240cDFVdDI4?=
 =?utf-8?B?TTVZWGVqaEpWNEozK2VER1hKTXNqRWJ4aHR6U0swSyswTUFnSjdBVWdaTDQ4?=
 =?utf-8?B?SGhocTcwNTF5TXRKb05mRndFMHUzK1IwcHpCV2dZU1hocmJjaVpwdnNaV3pv?=
 =?utf-8?B?M0ovQlRPV0N3MXc3Y2ZhNUFlMTcwOXhhVnFrWUFJUmE3S1U4UzRKU2hSQmFG?=
 =?utf-8?B?S2FWb3Q1aWNXbjljZGVlaVZwa0d3Nzl3T2Q3UW9lNk00TjA2dGRxeUs2dXFQ?=
 =?utf-8?B?S2hQMkN2WmNkc0kzRDU3ZWZmQmhwSTM5T0JGUnhPWktPNGU0dWFQSGdybDN6?=
 =?utf-8?B?V1V6L1FmZkx2dDZJZnRtK3hBVHlzaHExdXU3TTQ1eDZIZEUrenpvRTNJN3Iw?=
 =?utf-8?B?b2NOaGEvYzhQNm9JbmZsNExzWW5BSzUxZzQwM013K2hHSEF5ZjUrbkQ0UzBN?=
 =?utf-8?B?SjhSY2o1R2xMaThMOGFqaVY4b2xGV0JJRkE4dUtWVUlxNjVOMjQ5NW1OUk8v?=
 =?utf-8?B?VmdCNEpkbEQyaW91K0sya3RTNEYweDgybGNhTDluSU9Nenc2V2ZlaDMrMGxD?=
 =?utf-8?B?dU1SUW02VUpvWE5OK0pHazM5a2lBL1ZFSEt5UkF0NUNjSmNNSjdHRnJhZ1d5?=
 =?utf-8?B?dWJDVVErRXFBa2ZLMU03Q2dGNzhCaTMrbWs2Q255OC80UVdiOEhNNGtVWnVk?=
 =?utf-8?B?MmVnckNFMzA2MWFOV2h6LzUwajJxaEVnblF2aGtuL0N3YktYR1duMnRTbTIv?=
 =?utf-8?B?aTJ1SDJTc3Fub1dQUGVqcDB5M0QrUmpjamZ1bHN3ZE5pY0dDTGFwWDQxVXRt?=
 =?utf-8?B?Y2RxbHUzejVYK0swakwyc1BRK2tuQ1c5QXBocFI4M296ZHQ1Y0ZqNXVHNkJG?=
 =?utf-8?B?blVOTVZsODloTmc2ZW5wK21nQllHemh1VGZEQnI5ams4cUtkbEFtYUJQdVdH?=
 =?utf-8?B?MGxrUWIzdUtZdEFEbWtZN3duZzlNak9VRnVDWWVTMmRQZm5LNFd3MnV0Qm5a?=
 =?utf-8?B?KzFLSThQd1lFeklxMmJhVk9oYytOUjV6OE1mSWExOFE3MEF6c0tkK2tkRjl3?=
 =?utf-8?B?RWFybmFWbGxobUtFelZ6dkx3WWRBTDBpcFFGY3c3aVFpNFhRenJKWkxZTmRl?=
 =?utf-8?B?Q2RyeWVyam5acjB4YVpURWRVYVFxdW51MlMzaVIxdkVOcGFBL3JMcDdCZytn?=
 =?utf-8?B?ZktrZll0TnpSblhVRE5UY3hHeklqWWYrWWlCcEZ0cHdYVWY0alJhb0tUdGVn?=
 =?utf-8?B?Nm1ObWJmNzJNWkY3UzV3a1NWQ2F1NkVURU9xeGxPM25HODkvdjNtamVabE55?=
 =?utf-8?Q?Cis+cCD9NquiLiEyx7yRkCU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d153b2e-2a70-4d93-eb5d-08da0201ebf9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 19:20:51.7021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sz5u35A/43EoFs//LFsgFhr596VfPdqSYS+3Zb08HlT0dCz+9g+drwQEYsFKgpExyqMcU89t18LO4zfqO2/20w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821
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



On 2022-03-09 13:58, Alex Deucher wrote:
> Enable scatter/gather display for DCN 3.1.6.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a47370058088..da9628a0212e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1481,6 +1481,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  		case IP_VERSION(3, 1, 2):
>  		case IP_VERSION(3, 1, 3):
>  		case IP_VERSION(3, 1, 5):
> +		case IP_VERSION(3, 1, 6):
>  			init_data.flags.gpu_vm_support = true;
>  			break;
>  		default:


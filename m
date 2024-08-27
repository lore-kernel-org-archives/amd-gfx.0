Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1B4C54731
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 17:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B63110E3CD;
	Tue, 27 Aug 2024 17:20:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="od+PpiX6";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ABE010E3CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 17:20:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5XJWJgmJl9G21idg1oXn/2Kt53wQfmvQ9ieBINfVydSgYvCXNhvOldETYbOP9C4Jp03Er0Hfuz02kRCsM3FZ512BkfMgi5EtRaEEEVSCy/D7dFL/L4Lq1rh1PM1srdbp4YA8nVqyTy1aqa1kF/XAvMZXcpmeTmY5lv20+ur8b3ngMh1IJstnM8DVaGJJPHXCtnFu/m8XUCXY4sBMNSDgplNE1wt2n805xaSnavDLF4lm9VLm+ziwT6VliGa0OT6bB3FBmUuGQferA8UmFqxy2DyYZhUCeQl+S5SO5hm3cVW1uaKRUNnsyxDCw5p/buV1THLxTsfdeSUEJBzvFAcTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nP91JVmSo82yCAd73jfmTDFPV2spoe8ITY3W8lJpZKg=;
 b=DL0EdvHMqsPDNQuI8QfxgiVz7UmVkrO01H2BarqNjLpnNz2saMJd94fniChgx9pxT8yOcPP25G0YjLaIpnSAGBqtiOBQ/QLqZwr5DYDa8WloLlFhfwQAr12h7e7zJ1JfNCbFX0Z3eixa14taiudt0NjTGKiadE/ZkZX8XCvMO0ZWY2YxJ4lv4hQKS4S4iAbj9PxKqRvxT88xyiisD3DzxEnJiZVM0jwjSSbTGLUwsXuFxX5YEzTMAuMMXgieMLBT9KzyLhpjZJHPwL23tph/cUaBU+c1sfXPCxJWQhsYMKiu2d5WibLJvMVKnhluFd0ursIVgEFizLspwrBCzjKl/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nP91JVmSo82yCAd73jfmTDFPV2spoe8ITY3W8lJpZKg=;
 b=od+PpiX6v0SthjvhBZgz5fKvCldftzzFUWeFiIDzQEQyX9tk+0khlXIrYQGI84zW/zcVzWQkyhbtBk6E3N26+VrnqniTjeVTU762eLoYdVjvloZAEaOnRRKqpjHXe20B/5lcwaMbhSGrxzlKnIvEmqHO9GZO9FKdXVqkgdf9yU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CH3PR12MB8209.namprd12.prod.outlook.com (2603:10b6:610:123::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 17:20:46 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 17:20:46 +0000
Message-ID: <93d0c50c-bedd-40f8-b110-9c082f79909e@amd.com>
Date: Tue, 27 Aug 2024 13:20:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix for lightup issue on Lenovo 4k60 HDMI
To: Fangzhi Zuo <Jerry.Zuo@amd.com>, jirislaby@kernel.org,
 amd-gfx@lists.freedesktop.org
Cc: Rodrigo.Siqueira@amd.com, roman.li@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com
References: <20240822191417.622336-1-Jerry.Zuo@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20240822191417.622336-1-Jerry.Zuo@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QB1P288CA0013.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::26) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|CH3PR12MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: defb25e5-b468-410c-ebad-08dcc6bc9655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWUvRStzY0FXak1PaWJoNmhWSGJsZ3lYYVFadklleEVCZFdxWUFZeTVSR1ll?=
 =?utf-8?B?TVVCZ3prT1BtelNnY1hjUWpMemx2TVkxMDhjTXRiN09TaDU1VUMzUlJIbENo?=
 =?utf-8?B?RXBiZXRITjkrWjZhdG1IVkZxM0xuZmZ2MU9yRnhwdUdnaUR0Mi90dXd6V1N1?=
 =?utf-8?B?RUIvMmRYVzVzRnBUcTNWWmtDUU1YZmZVTGNGNHAyMkFtUWdiRjZGY0lyV2w4?=
 =?utf-8?B?U3BuRThqcEVhRzRHMVh2cW0zMGltMmZHaTM1LzFHS1lTcTVzd1huZWpnWXZP?=
 =?utf-8?B?M0grZU9Gb0xhamxHQTA5Qk10UzNaaUdqY2I3WVFzUTBTZXBBRDk5ZzRsMkkw?=
 =?utf-8?B?THdkeVRWSW5xVjZZV2ZJNUV4Ym9HNXIwaGJqVWhDUXY2a1hLb0tnakpnRkFI?=
 =?utf-8?B?S3lhNERpc2xyYmwrK1VabzhFd3Rxd3pTVU51QXFNSElZSHlVRHhoa0ZDNklT?=
 =?utf-8?B?YkNYb0V0NkpBRHduY1hvaE0xajEzZUdmOUtNbmMvZGFjT0VyWjhvZG50eXBt?=
 =?utf-8?B?MThtS1hpUFVUMEpPcXBOOWVVUUlzUmptUmVPRkxuZE53YWRxVHZ0Z2JJUVpv?=
 =?utf-8?B?Y0Y4SHkvdEVabnZ1UEVON3F2MG0vSWg1RzJZU3JHazY1RWh3eGxMTm5LTmdo?=
 =?utf-8?B?eDY5VC9tazFLYlEzcGNSMENVSGQrK3VUcTI5Rkg5a0pvci9YYjZQaUNzYW94?=
 =?utf-8?B?RFJzWEpHbEVVNGJFT2RyaVZTN1ptUzRxYWNmb3NvV2M0akJQYlgydE5iN1dE?=
 =?utf-8?B?TFdOTnZxeHJTTkY0TFArTHVJUDdhMHdkdE1qekUrVXdxbE80RlR6U2pHMmtx?=
 =?utf-8?B?bHF2ZUsreUFJK0xkUlltblZPK3Y3d2lzc1dOeHZsOWt4S0JKSXpUSHkzZFFp?=
 =?utf-8?B?emZtKzVmZFczL2NMcUNyaGtWWHBNanVNd2ZEMEtWN2lXakpiRkVNQzRuWVhM?=
 =?utf-8?B?U2lQOVMwUm8zdzdFdHhPczFqM0wwajdtSDlRRmJoazBhRVJXQjN4amVYNWgw?=
 =?utf-8?B?M3dRdFNwQ0ZDc1d0eGc1dWlrbDJ5YWVrQko2d1RNNllhS3prcEhNN25KNXJR?=
 =?utf-8?B?b0FuM2gwdjhjWDhpdWlWeGllelJEeXpDeWJjVVB1TU45V1dOVGIvWWpYU3Nm?=
 =?utf-8?B?OTF5NlFJYTI4NWhDRFhwenBJVWY1dFZVSUlzUW1QYmZraWtaK3FuTnUrUHVj?=
 =?utf-8?B?ZXEyTXR1TmhhTWc5eENTQWZvcENQRG5TMVgzK21WaElUTExJbzJER1llZmRm?=
 =?utf-8?B?aTZPZmMyNVNnVStBSVh3eHBQVEhyTWV1ZS9OSWNWV2o1MlZtYzdwV2gwQzBk?=
 =?utf-8?B?YU4xbUNQT29pVUh1VEVFRDU4TWcxcWV4dk5xVTNsb2Z2VXhaY0p3RUQ3L3R4?=
 =?utf-8?B?WTZNRnJvQ3BwN0RtbUZRRU1vLzhKMDV1c1JIbTl1cGJqS1piNCtvR1hDMnps?=
 =?utf-8?B?RXZ2dG9sSlcvZVFWZHc0cVd4ckpFY29vRlRRMENQWk9YV3M2UlVSOG9BTkVI?=
 =?utf-8?B?YTlTazMyUUxqVktiNnVlQmFHQWVUa0pkNjFGTTNYNGFRSW1XMVI1bHdIS2Fu?=
 =?utf-8?B?bXRkK1BucC9Rc29sTzFGczBIaEFKcGRhRzhoV3ZyUlVPTFRCOEJtbFc1QnAv?=
 =?utf-8?B?SGJ1TjJ6b09WTTlMdU5ZMXh1L1R0Tkg2TnRLcjVmcmltNEdXdWNybDhQd25S?=
 =?utf-8?B?dktuT3VCK2FPL2FVUk9qS3JuM3JpN01ja2VpbDhROWdqRzNmQkxWazYrQzln?=
 =?utf-8?Q?+1fbDy0uRC0ZSDQc90=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3VNMnlJYXhBSzZYNkROMitDbGd5d0ZFWUdDUkZkaW40Q3RwQmVSaEFWVUdR?=
 =?utf-8?B?MkdPVTRBcm1YUnJiOFRoa2RTOVZ0OE1iSWVWSWtmMXY2bkVBYlcycjlmN3E5?=
 =?utf-8?B?OUk0RjRQanVuT1RRbzYrUzdWRXhsOGFRMDArck15bmtsUE4zOWRmbHBTQjMy?=
 =?utf-8?B?L3l4a3VxeE5RU2pkemV1MnBhTEltKzJad01id1FXV2dZRjNDWU1qZnFPS09n?=
 =?utf-8?B?cVgxdjJOWjIxVjhoTm9ONXFaWjdXVGhYWGNEUGx1NGN1Y3UyejhNWFp4ZU12?=
 =?utf-8?B?S1FQeWZrWlBxUnVJb1dRMDRKTTBZdHgrRllTRlptQ3FEWmt4MENVTGVYODBK?=
 =?utf-8?B?aWZhcVA4KzdkNHpjYUl0SVZjVGFTaUFmMldKbTZ3Yk0wVkQ0Nk1ieklMOXpM?=
 =?utf-8?B?YWxIRmw1STlWT1lTUkhEWmdXNzV1ejNSczVxM1BoTXEzazllSFc3L3AwRitF?=
 =?utf-8?B?QytaTWRPWmFZMDNoWk1PNGpjcWRNQkt0ZFRObVpKM1VIL00wSW16eHovZGZp?=
 =?utf-8?B?UitjU3NITkZocXJYRmRlZDlpd3BVUHFNOGQrSUV6M1RlWXZtVnQrTzBmbGsy?=
 =?utf-8?B?a1Nvd0oxZTlvSzA5NlZoSkN2WVc3elJ5MDdkZHZDSGc5Wm1lcjVxc0MzZXRB?=
 =?utf-8?B?RzFoZ2YyUlFLK0UyenNVcWU2RHFWSEd5UnVBU21mSXNob254TUczbklmMkVD?=
 =?utf-8?B?OVJ4anduUTRUelFscmhBNEFkZ0xzMkJyT3lXTnYyZnA5VkFQNXB1VldUMGhw?=
 =?utf-8?B?b1doR3JwRDR4Zi81aGgyajYvK3RtOHBQUmF2RGtrdUxESU9QRzR6anJSREg4?=
 =?utf-8?B?SHBMbU5hRGtzTDZUeWVJc3B4MU9oWG9zdHkxRjlnUWhJVFRybnVhSXpkMjZY?=
 =?utf-8?B?ZmtsTVNrajF1MnIyRTNzc0ZKaUN0eGdrRmxoL1hOb1kwSlhyakp6bHlVdmZj?=
 =?utf-8?B?K1I4NmV2eVhUdWF2WWlYK0FjMGY2MUxXOEk1UDNZWlFhTHhpeExWRXRtcGtu?=
 =?utf-8?B?aktvUU9NTW9FRzhuZGRXbG9iTFRxOURvUUdxNDFpUUFIMWIycjFGc0QrOGdW?=
 =?utf-8?B?Wk82QjRDc2tLUmxNdENudW0zMHREdVl4UTRJOTlkUVNVZUJ1czRNK2xKd1hI?=
 =?utf-8?B?b1VNMWg4MWkwTGY5YTUva2RvQnI0d2Q4ZVp3NHF3TkRpV3BXS1pBdFFsKzZU?=
 =?utf-8?B?Vk9JVEdDbFlZZjVsemJRbmJ3YVByTjVadXZVUzNCV1Y5cDJXdzE3ZGk2cCs0?=
 =?utf-8?B?WW5XYXYzUW1ibkVPWXlwMW9vdlJ2RTZqZzBGYWVDdmVsbysxNjdEY0FtMTVj?=
 =?utf-8?B?Z1c0ZHFyeTlQSjFDTE5rcXNyZ1RzaHJEVGE1UHJQRERsUzZtb0Z2aHdQV0hu?=
 =?utf-8?B?dWFyQSt4Q2VUZVl4SkxyckhpVnNqNExDdi9oRlk3MHZ5YUJSeXFmN1pWN0hW?=
 =?utf-8?B?Y04xb21SaEhrK0ROb0RZRnV6NU05VllFdXFBWUZJRlBGZHRqUlFmeHBkZlpP?=
 =?utf-8?B?bWw1MitOSEI5eS9nTXNOVmZ3K3F4Y3B2NEdwN1BQeEx3R3R3S3hJMHhLelky?=
 =?utf-8?B?TERPeWdWU2MvRmxtZ3E5MUFRK0Ezdndya2Nab1ZUcmZlZ3BwNDNDb2NVZGR4?=
 =?utf-8?B?cWZFOWxId1l1QjNwaWxtbk5hRzViUUZkR0xJTmRPLzNtemp0RmtnNzhBdG1q?=
 =?utf-8?B?eVd1K0pYU2FjakFJZSs5VXFjRXJBN1VmL0hTOFFsVVBjaTg1ZFQxQVRsM2dR?=
 =?utf-8?B?SUd6dGt0RnBiVFJTLzdYS0JHdGFlR21vTVdvVlR2RnQwcC9CSEhuNlBJbmFN?=
 =?utf-8?B?Z3IwanFGMUJxWEs5ZlU2dW5obVVyR0liZUx4WXZKN0M3eldrL1NqVWpwSVc5?=
 =?utf-8?B?eWFGL3A5VHJRZnFVT0llaWJMbkRUdWlFdXBoK1ROR2poc1JDNDhZeHNLckJp?=
 =?utf-8?B?bnFWY01UWEowVVhJa21FcHQ5VU1MSFAyTXVJM0dqMExoMFV3aEN0OHgwTWV2?=
 =?utf-8?B?YU51c21HcmRVMFIyWUFsTnc2R1VYNHMwMlV5QlMxUW9aR3pHVHI3djlOM0Rq?=
 =?utf-8?B?QUU1RmRzbUFYMktVbFBDRm5QajJ1WmJKa2FvZFRQTmhRWVpHZ1VRdlZlY090?=
 =?utf-8?Q?B0wm+vb6KXmSHzy8QOKKQcUu+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: defb25e5-b468-410c-ebad-08dcc6bc9655
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:20:46.0518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avzOqwMLiw5wCMEm1z1nNqkqdUCUfrqKIQvL5t4DTrKAMgG3JO1zctg/zoCgNnMciRKjP8mKkuUj7YIP2DVmOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8209
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



On 8/22/24 3:14 PM, Fangzhi Zuo wrote:
> 338567d176 ("drm/amd/display: Fix MST BW calculation Regression") has been merged
> with a mistake being fixed by "drm/amd/display: Fix a mistake in revert commit"
>   
> Fix dsc enablement for Synaptics Cascaded Panamera hub is included in
> "drm/amd/display: Fix Synaptics Cascaded DSC Determination"
> 
> Please apply the two patches on
> https://gitlab.freedesktop.org/agd5f/linux/-/commits/amd-staging-drm-next,
> and give a sanity test on 4k60 over Lenovo HDMI output.
> 
> Fangzhi Zuo (2):
>    drm/amd/display: Fix a mistake in revert commit
>    drm/amd/display: Fix Synaptics Cascaded DSC Determination
> 
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

--

Thanks & Regards,
Aurabindo Pillai

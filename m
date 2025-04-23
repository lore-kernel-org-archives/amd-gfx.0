Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CFEBC369CB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 12:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E53CA10E66E;
	Wed, 23 Apr 2025 12:40:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bPIRde6y";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0852910E66E
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 12:40:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXG4uzB4CZfXuI3SEWRUvjHMSj+DQkqaU+o7nhyudwRHtq8+C7WLsFYVGYTnlNr7m2+wFGP3rMOQpnINZP5toVuHjKuKoCeabHk5SBZfCXdd7iNV5J2szcuEaR5orau7TueO8dkio+pM69Pc+s5ijdBX4Up4d0LoDYgHdzTjXIWGL/2+6SP8HBjUObtNk/kov42CnaAmtQbDDernB4WKiZUBhaD/Wx9cPALv1CAgMDX4ChW5cMuJ5eQo68slyZsgtUvm09nC85tu9//TYRoa/Ai30BZoGnNopwAypCuzu+i87CUBnl7UrXgxJ5CfRRx51LEC/QlPlSNt//jH+y45fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VZMyWmU0I1wkCdVfbqPH6kDTHfp+3Ivi//RKCW0obg=;
 b=dM7Yaw6cmnDau9JGKhag3fHI0nTwpImJr+6buciMX3XkiBoGeg7tqKzYQNDifx2ypgVw7CV1W5UtzzMv5BGVR/FL2+w87y5qFsoY6HhB9RJrRga0m/GLB0g8saKw0cd8BeoyorxwmcilocPgFiyVYIE7oyfwVL11aT/eOwlNGEFxc6bFzSDeTIk0bPSU6cIiTdV2RMvsurDADhpVOScA6EIcI41Z26YLi17rua8EtjfxEvBRVHCjaN20hFFpd2Irc8OEraTCN1KJrTQd+bi0WhvKtsWQFL0GZEG4c8swdhQtKqIKYiiiAgBz3wgAxVaOUHSkVYkLHoqYCHA3nq16Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VZMyWmU0I1wkCdVfbqPH6kDTHfp+3Ivi//RKCW0obg=;
 b=bPIRde6yV9xk603NzuNO/UJMJG5S33PIf67702+9vWFEDCW1LaGiFEHC1p0/tYXGBy8oXdK2Gum67IWdDy/dHUn3oHX5uH2YFsbQ2VLiRpntngNWjElbsaVZaCHZRxqkt9nBKvXqaHos2cRtx7EZoClTXgUVBt611N8YhmjSwfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB5717.namprd12.prod.outlook.com (2603:10b6:8:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Wed, 23 Apr
 2025 12:40:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 12:40:01 +0000
Message-ID: <991a1499-69be-494d-bff7-810134a8bbcd@amd.com>
Date: Wed, 23 Apr 2025 14:39:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd/amdkfd: Trigger segfault for early userptr unmmapping
To: Shane Xiao <shane.xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>
References: <20250423095036.1413882-1-shane.xiao@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250423095036.1413882-1-shane.xiao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0244.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB5717:EE_
X-MS-Office365-Filtering-Correlation-Id: 693e7976-e051-431e-4dcd-08dd8263f6c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHlCRzU3azNyWERmZU9tdUdTejVvUWFwUXpVMGdRb3Nxb2lPWlUxSk1HL0ti?=
 =?utf-8?B?d0FERE5zVm5PdTArSkNRRk1yMlk2WWpyS1V3dFUzdTdtMGlKajA2QjVTdml6?=
 =?utf-8?B?ZWdyL0VyOHdyQUp2T0NsaWJseVJBRm4reS93TExPSUcrMUNkU0Jsbk9IelJG?=
 =?utf-8?B?YU5HbVRGcE9lOStvbTZ6bDV6NStxcENOa1hhUWtrd2RNZWFoS3ErSjlvOVNv?=
 =?utf-8?B?a1BiR0U2V05Ec2F4U3ByVVdRaXF0L0JyK3lNNFBKOW9nZWJUSjNhaWRsb1l0?=
 =?utf-8?B?TUJlNnZmYTBXbHBGWTltbzZscTJNdEpGdEFUNi9MdjhYV1A1TmR3QkVseEVM?=
 =?utf-8?B?WDh0NWdUcjVpcjltRTBIdFZ4ZFcyeEpYeGZwSVdhNzZVZlBtZ3U4bGVNaCtK?=
 =?utf-8?B?TjdvcDBMNXFNVkx2N1gvRjlIVXdBM3JyakNBSzBqY0tWK2gxR2lhNzAvQjd6?=
 =?utf-8?B?NXdtb3ZDYm5rcCtCS3ZIY1ZtNUNvTmtpaytpdXYrQUFuOWU5bDNsbXRablg0?=
 =?utf-8?B?UXV1aGtJWldGQ1BFME04VVZxZEF3amxVTXUvQUJJLzdxbjdsYUN2aFRXL2xu?=
 =?utf-8?B?MjRoZ0FvYVB6cVJ1RFNvK3A0YVNKZ1dJMk95RWdBczBYdHRoZzk5SEVLSmxy?=
 =?utf-8?B?eVI1QTBrdDZhVTNGUlFlSFN4VGFNOGJZRERRS3BDdksrZlBPamZzZmFyK0RF?=
 =?utf-8?B?R21GTWIxSkZQR0pUNWZoeFJCcFEwbm45QmFUdDdOTzJ2RDdLVmN3ZkV3MVUz?=
 =?utf-8?B?dEd5c2lWdUp1MnFUMUxZYW42aGRmUzdHeDJha0Y1K2tCeTN4RWFoYmwwdU1M?=
 =?utf-8?B?U2FUUHR1WjRRM2p4b2kvRGxlTE1Kd3IvajcwanZseXovbXFwTnBkTEN0ZEll?=
 =?utf-8?B?dmt2U3k5emdhWURCb21DZzV4MjFqTms4TzV4U0lmOFVrNU9naEI1NkxrcU5Q?=
 =?utf-8?B?K05rSTJtVHN4WERneE1aUnZPbW9GUlhjbFVKM2UyLzFGeDA3TU5VSWs4U0xR?=
 =?utf-8?B?MXZEVkdwcllmakJ0b1J1R2dGM05TYnJrRUdXampvanB2TEtMdTN5eGs2UGgz?=
 =?utf-8?B?MHRHYUdpbGxkN0pyZGhtOG1oK0ppeG5RNG1OYjUyQUkzV0Zoem91VDNGa2pK?=
 =?utf-8?B?T280SjdBNEVVbHhNOTdrQjhncDl0V01JSkgzOE9wUktsWmlmMkU2S2p3M0tj?=
 =?utf-8?B?dlNGbExOenVaSGE2VTgrYWFPRitiRDRScE84aWFJUXBReVBVSis1VWhDZFZH?=
 =?utf-8?B?UWJnM2RpUHN0R3poQTdRcjFXUVR6K2FIbDdkQ1lNeUlsTys2WGFtaTg1QUNX?=
 =?utf-8?B?RWNacDVBWW1LNDYzTTRGUjBPdFphR1JGSTd3SnBLZE9vcnJVdjJxekR2VWww?=
 =?utf-8?B?ZS92NndKYzVnTHB0OUp6MEs1NzdwRGtNZVBJeVBMSDlRcTJVa0VYMmlvV0Ro?=
 =?utf-8?B?ajJGQmJlT0FFVmVKQkIxNDFvbFFTQS9FdXFBejVPT1Zrc2E0M21yT2t3bEZC?=
 =?utf-8?B?VEZrMWhNN3J0aHZhZ2tJNFpUOEtwRnhYOHErLys0dEtLRjFZb2QrdGpCMVZY?=
 =?utf-8?B?c3kxWFlORnpUbCtVNjJMcjhPWHdRTU93YjFLTllRbHBmMU16SHZNVTRrVnRW?=
 =?utf-8?B?UmQzVXFtWk9SVHFjZmkxR0FZT2RYdU9sZmcxVHYyN0xnWGtxZ2FzVmo5MHhG?=
 =?utf-8?B?RGZqeGN2WVZnTW5haFpQZ0pxQUNMcjhBNmxJNE9ZRU9idXlHU3d6UDkyaXJw?=
 =?utf-8?B?ZVdEQjdDRm5SeFJ6ZzFuWFZpdEtkWUtueTd2WWxVb2NyeU1MWmo4YmN2Yklv?=
 =?utf-8?B?djhXOVRLZkl3TTJXR0U5MnRiRE1BT2luRitBYTlrUHpBdmM5L2tTY1FpOXk3?=
 =?utf-8?B?NGJ2M3hxTG5LR3hCUk5idGlSbnc0cHk0eWltRzdmL1hHdXl4elBNd3VkZkZr?=
 =?utf-8?Q?mNruLs9DbQE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZklObE1EUTJVcWRjL2t0ZWtRMlV5S05wb3lqSGREZld3Z0xtOWlJSUpCUmFt?=
 =?utf-8?B?YUJjN2NPcUdIT09SWnRaU2kyTHI3RXB3OFZUZVZzVG9QTUVTWmNVNjd1bXlV?=
 =?utf-8?B?eFIxMjJEVjU5ZTYyVWk2YUtqL09kc09TdFBBNnBSSGVrbWcyYU4vTkt3SzZU?=
 =?utf-8?B?QTE4WnVkdmhDUTFkS1NOTmdCK3ZXc3ExUUI1bjQwaC9jT1pQRmJtNjVnN3BW?=
 =?utf-8?B?dmRmWEFGZnJjV0hSdkVUUVdhRUxGcU4rZHRERS9xNWNXRjFvY2dZc2hYNnln?=
 =?utf-8?B?dTJuYmNEcTIwOG0vSHVMNVg5RG5EU1lHWGxhTy8vS3VERDBKQWY4bUpQQjQz?=
 =?utf-8?B?dDRvUWx4blY4VENuVlI0Y0ZJckdMa2xKV0RyOTZjVXBLdVpadjBRZkNxQy9I?=
 =?utf-8?B?WFI2aEczczRDbW1pUzR3bkQ1cmhqemhSMnBpWXk4TVZGVzZRQjNIUm1LbWZQ?=
 =?utf-8?B?S0taOXNQOTJwRFlFU0ttdGZaWDZrTTMzdWJub0oyRzdBZWpNdnVycHVubk5s?=
 =?utf-8?B?OEpFUE1aY2xYTERZNmtYUzZDNDhTUmtaM1VzUVh1WEdJdG43Rk1NTko2QThV?=
 =?utf-8?B?dGNJRkVGV0NWNXlkTjlGVmE5SFR5OSt5Rk1lYmtSaXdScHlHTkFlMFd2N1JU?=
 =?utf-8?B?a3FrYjd1MXVZRkxtdVVxSVhzblY3bFhGTUo4WEdOZzZpaU8wbTQ5SUJ3VGZu?=
 =?utf-8?B?MmhJb2lxbC9MRkdOVGc5a0dyV3FGY29LOG5NV2VBVGYySXROUWYxL2R1b2xl?=
 =?utf-8?B?SHEvQmt0aXNsSVlUTmRNQ0xVWFQwUk5TZWZsT3lla3hjazFtS2o3SndoVkVX?=
 =?utf-8?B?aytHUThOTDhlZW1HeTBXTzdKV3dIaEt0OTZwcEhyZytpRVA2M2loSjBVR3ZN?=
 =?utf-8?B?TGFhQXU0WTVGekQyb0crVmRZNjZta3RvQWNkRC9oQVRianVsZjlNUUFvUUNH?=
 =?utf-8?B?eHdFNzJkZnV4eUJ5cTBRaU5FV0xtNXJRRTY0aW40a0ZSTi9HL1FqVG5tSkpq?=
 =?utf-8?B?Y2R4UDFGUGp0QlJnaEFWQnpEeE8ydTdsR0w2dSs0eXBqZlhNQWRPeXJrNlJE?=
 =?utf-8?B?OUFGTzJuaHkvN0x2ZEFPbkFvSnpEQ25Lb1AyRzVtUlFHME9KTlZQU0F2Z1lu?=
 =?utf-8?B?Q3lOelVyQmZQYmo3VW05bU56ZEFMb0NpQXBTdlhTTVR5SEhaMDBxNmhtaVNZ?=
 =?utf-8?B?YXhSWlc5aVRzL0VQVkNMSVJiQTJPK3gzSTZOT25FS29qL05ITWFDSFFDaUd5?=
 =?utf-8?B?V2MvUG5YcjNWM2luMnZXTVhUMmtRMVlHRS92dDVLOWpJMmZyZzVmUDBmaXJu?=
 =?utf-8?B?M0FLM1VNYjBTUHB2QmYyNzRHdktheHhCWUJ3THZ2T2JkVVl4MEdmYXhpbVN4?=
 =?utf-8?B?MkwvNjJEeW8vRXRIck5ZWXJCanh0WVhWQWUxRkk2Kzhwc0N4Z1FqU1h3eHdp?=
 =?utf-8?B?a3N2cVRMWUpOaG81UGFDTjBuZEM5WWQvRWVpUlhBV0xHQkNBd0ZRWHluV2R6?=
 =?utf-8?B?WVgrNUk5OWIwbDJTWnBmengwSHFZUUt2SmxOd1cyMG1QVmtuTTYwcnpyUUt1?=
 =?utf-8?B?WTNjbFM1VEN4djZSVVo1MWZPNnB6TEhFTjlCZ1RsQ0h2bXZRL3dLWXVacEtT?=
 =?utf-8?B?OG9NbktWdElsNmdOcGNnWjVwYWVEY0x3Z2lRdVQrVlZUckFWdVlmOWdXZHo4?=
 =?utf-8?B?blA5SVVYNVR4aFdwNW5aN0U3aDdWVW84SDEvak9xcC84d2VSeFhBYjRDS2hK?=
 =?utf-8?B?VWNjVHZOQW1LTG15N3djOHE5V1FOampBYjBka3dveEdkaU5kay96Z2IvMm1u?=
 =?utf-8?B?N3VLYUJhZWt2MEkwQXo2VjVlUzB6L0VEMkh3STVNUWhkY1JBRWorM284bGZV?=
 =?utf-8?B?RmNkM210Qnl0Qjh1S2phc0xtMnZMdUxTeTJLdFEyOC9hM2hWSmg2Sk1zci8z?=
 =?utf-8?B?aDVjV29mZHB2eTg2VHc1UmIwbDkrUUdVQ0p6VXdOMGZrQU02T0RpUC9UejlO?=
 =?utf-8?B?VDltdWEvZmhZYlZTMHQzNkZVN0pnT2Z0U0d5QTNOVFpiYkdweVdLdk5mYW00?=
 =?utf-8?B?WFdOeEx2bW5NTGJSbHVmUmhlNldHYUhBZ3AzSGQ3WlQzdVk1amNFUFVRb3RC?=
 =?utf-8?Q?qnceJ4FNXdGbe+cuW7Ztw0O06?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693e7976-e051-431e-4dcd-08dd8263f6c0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 12:40:01.2275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epe20jfEF6R1yfji+MzUQJgmBK8OPFlti3a3XW2VYlKqlnzy9MPp5gfgRHJvySPU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5717
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



On 4/23/25 11:50, Shane Xiao wrote:
> If applications unmap the memory before destroying the userptr, it needs
> trigger a segfault to notify user space to correct the free sequence in
> VM debug mode.
> 
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index d2ec4130a316..259b38424b7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2559,6 +2559,16 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>  			if (ret != -EFAULT)
>  				return ret;
>  
> +			/* If applications unmaps memory before destroying the userptr
> +			 * from the KFD, trigger a segmentation fault in VM debug mode.
> +			 */
> +			if (amdgpu_ttm_adev(bo->tbo.bdev)->debug_vm) {

Using debug_vm works for now, but maybe we should have a separate debug flag for this.

> +				amdgpu_ttm_tt_get_userptr(&bo->tbo, userptr);
> +				pr_err("User space unmap memory before destroying a userptr that refers to it\n");
> +				pr_err("The unmap userptr address is 0x%llx\n", userptr);
> +				send_sig(SIGSEGV, get_pid_task(process_info->pid, PIDTYPE_PID), 0);

Drivers should *never* mess with send_sig() directly. We made the mistake to allow that with the KFD already.

We should rather send this as GPU access fault or something like that.

Regards,
Christian.

> +			}
> +
>  			ret = 0;
>  		}
>  


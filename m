Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC4BC27C6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jun 2024 11:50:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EEBB10ECFE;
	Fri, 14 Jun 2024 11:50:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2EZJhrfL";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05CB310ECFE
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jun 2024 11:50:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnTg6JI2BtfGMDpa97wttZDCfXtoFyJSFDgbFnpnPo45Nis5OFP5K9HP2eTJvJxsFrI/xoCSFuW/RdjiyhnkgJKYM4EBiGqRmOLSv2X3teVkNjxzOnZWPR7Pm9AQdYW1k+ytXmn2bnIhvGla1+XYs8Ppdbq1T6fVHlZXdLfPLSEV+wWn0Xj798hMkZvVOyzXRtZin7IeNubJREHpMufRX2x73UuXSN3ab6opE4M38Q3k6p+PXJrMf9iG4s2vYHHUwoh2d0q7Hpm4KACKdvmMwXNgYLuNDEjUXWzlPLgmPMzDHHq971f6B7WsgBge8pVEmRJxeqGuuDiHZJTXGDeHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7vvqc1CExPCGnP16S/kYsICsXz1RU8Na4NRQE3ItGI=;
 b=aysrik52HdH9LIKqloVDoqBbfChQEY7bB6APZ3DwLZuhcHP8i/cJklcGo0gFMvYkUo8TINzQFDkOUKetpTlNsIBH/RCtq3aD/HdG8k7G7rn+yEEQSwJLrOPPcRJmnssCS6IPgdM+wn7svs/L/rQRe++8W2LqJ244cPPiZLyy8pb8ftEZwZcys+gu4CEN9XPT3CuCvriEOdzX2CiS1Dz6wNEsrABNLJpViW7Q9/0/w4bA/fd4ZlljG8WMJ972H/Rgcn19srMfOX7XqneTO95x1JfaeDvCnWtF288qcWseO30RZjH5Ct8mADMHFjcxFjAfMbRcRdNxHLXWnBVZJwsr5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7vvqc1CExPCGnP16S/kYsICsXz1RU8Na4NRQE3ItGI=;
 b=2EZJhrfLM0bXcZURyiASZ7ilbb6AriZ413O83EYpKg06dnggEp8OKwbm6U+TU+S+W+uHo58d4aLS5AFlkwylB/Rx9x/SI3l4qTrdbmrZxCtPGASl2vaO+D+EPcETvv9gW3pmv9YJfgTsS5hF4hvTYXSPB4SRj/4o9J3LEbyxRmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB7122.namprd12.prod.outlook.com (2603:10b6:930:61::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.21; Fri, 14 Jun 2024 11:50:30 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7677.021; Fri, 14 Jun 2024
 11:50:30 +0000
Message-ID: <2bf881e2-9db1-47f8-b8ec-dee5dd7a295e@amd.com>
Date: Fri, 14 Jun 2024 17:20:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: keep init xcc0 for all xccs under sriov
To: Jane Jian <Jane.Jian@amd.com>, Haijun.Chang@amd.com, Victor.Zhao@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20240614111022.236072-1-Jane.Jian@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240614111022.236072-1-Jane.Jian@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: 568db997-547b-4c5e-b772-08dc8c68307b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2RKMElTeVFmYnZLMVBrSUVKeGVOcXZsZU9GbVlnS0xTTnc2d0FHaFZNY2RU?=
 =?utf-8?B?ZHorRG5FTWtLOThXSW5xakIreTF3eDNVMDhsek9ScHVOWXJBZVZNOGsrMEY2?=
 =?utf-8?B?eU5aYjB5V1NKNTk3YXlLdjN3cTllUWJXQnE3MFcwRXJ1cmtVYmhreENPdjBs?=
 =?utf-8?B?TTFDUDFJUlhIZkdkcXhqVzNJNjFtb0N1Rk15bnRNRkVUenVseVNmMUVGMTZq?=
 =?utf-8?B?RjdSRlU5bHpaeUVDTFdRTWtjd2lTK0RnZU12K1RTMkxzYTdhVTBxbWFEdFNl?=
 =?utf-8?B?WjUwUXJ0T2doUlJkam9LMDBQazRRN1ZpWmxwTHQ3RThjUnhxbnhKT3ZJYUpU?=
 =?utf-8?B?eFJaS296L3RPTzJNRmsrUzJDU1FPbFFwZFNOMm9KcTVtSnA1L1h1NGVadVRm?=
 =?utf-8?B?WmRwaVRPUlYzVE9vOVJrSGltUDVLQUNXK0pJN2RsdEhuek5TMlJTTjRJY09s?=
 =?utf-8?B?Y2hMclRjbGpmK1J5VTVEeCtKN1d3NVcxZTUwVHV4WVhtbEtLR2tEYmdSTWg1?=
 =?utf-8?B?aGIrME5LNTg0Q0NnM1I2VmNvbTA3VFZPL0pvd2lZMmVobmFocFpZMDJLRWs5?=
 =?utf-8?B?YWIvQzlkVWNucDIrYzNEZUt1aDRuTkNDMnJwcTVmOEs0S3h5YW1EdnFkVFpl?=
 =?utf-8?B?U1MyY2U0NElKa0R2bTgrdnRSZmIyTVhCZU1kZTl1TzQ4T1dxU21CU3dSeHdU?=
 =?utf-8?B?TGE1NEsrUGhXNXhadmF5czZBOFRBLzlmUWpLelJjZ0c1SXJkKzFCa2V5T0lM?=
 =?utf-8?B?RmRKaTlTUXZCSzh6YTMzMmwzcjBVcHlQNnI4OFgrUzNxTWJ4Qlg3TjNVY3Np?=
 =?utf-8?B?SFpkcFlLUmVHRjVBbkptTVprOEJLaHhzVk94L3BMcVloUkx5Z3c5WkU2QTNv?=
 =?utf-8?B?RDVVNzZTYi91VmQwTTdzL3FVU3ZyWmNybmZzRGlhK2xneUZZTWxab05aZm5i?=
 =?utf-8?B?aGNQQmg4cEpZQlh6N3loaldOR3NUUGVWcGdpZ2tFTUh4bElpaUNJUGtCZGxU?=
 =?utf-8?B?elJXaU8ySUljWENZWWgvSEwwUnc2ZGQvaDFkcFNEQjFkY1kxYVZvWFI3OTQ1?=
 =?utf-8?B?UzBEVWcrZlI0SjRueVVYNlNiNWF6bkZrNngyR3IvV3R1R3FSaE5xamFVRmQ0?=
 =?utf-8?B?dk4raTJ2bXFmR2lCSVFvY0NLMEE0WC9JRkFySHUxdGVnV2J1cVF3YWRjQlVz?=
 =?utf-8?B?a2I1Q2VzY01ESmZZZHQ3SklySjNpZllUNThBd3AxK1JSZ3FuM1ZLRXZLNjQx?=
 =?utf-8?B?c0ozdTVlaGlxMVF5L1l0WkRTZ3A3T21UVGRVS1o1T0FnZUxxM2RCVUR5a1Bk?=
 =?utf-8?B?QldxWGw0VDg2RDQxUzVVcko4c0hsbERjYmQ0b1pHU01tWm9ZMmJwM2szMGd4?=
 =?utf-8?B?TGFIZTgrc3MySHNhNExzajhPQ0dYd0NCL1pBVHRYa203THhFbHZ1aktZckZK?=
 =?utf-8?B?c0ErZk92UVNzQmRMRzAxenR1UVA4U2d0Y1NHellibldtQmlxYThST3NaNzVT?=
 =?utf-8?B?TGZzZW8xSDVBOWtkZTFqTDlpNXFWOVJWWlYzVzVwRzlvd0x3bkRBNlF5eXZE?=
 =?utf-8?B?NGFYcXdUbWFVUmtONEpBSWpjemRlZjBRU09BclMwUTAxdTJlRTdsWWpZaUlr?=
 =?utf-8?B?VUlvWlpHWnZGSnlGNkJ0TjhmRlQrNStQNFcycUJXSWg3c0QweS9uN1VzcnI0?=
 =?utf-8?B?cFg5THNDYmlIZWhFcHdLdEJPL1o0NEZsL0ovUTVvVDRGbGg5Q3l2djU5N01R?=
 =?utf-8?Q?PxmgZMSzjOPpij0tFaJ8m2ThhbMg7lCPE6QDCyP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnNOdGppVU95REI3dmdXRXZzbTMyU0xNTXgzV3ZBY21pTC9TaXE3NkRpTmdU?=
 =?utf-8?B?Smg3OG5KRk5RM2N0V2h4QW9pd2RFejFLMUxNbnFHR1RkNExhTEhqR3dZUVp4?=
 =?utf-8?B?Rzl2YUZyeEgvMlQ2R0pVTW1sdW43cXBYSk41WHRLZlhqMGxEMXFhYktGN3Rq?=
 =?utf-8?B?alJjTmQ0SjNmZkVXbmEyWnE3eS9GaHVMMEFZT2lrS1QxTUxaSklXMUFBR1BC?=
 =?utf-8?B?TTl1S1U1WmtwbmhwcTFaZ3VQLzJjUzVmckxRYVVxMUN4TUFqVmU3L3F4S0dn?=
 =?utf-8?B?NzMwSVExc1grYy81M2hPazlxOVdyK3NqRk9FZW9zb3FBaldPSk0zcjFTcS9Z?=
 =?utf-8?B?WmdBQzNPWDBmdFlkMU5JRXBLT0JycHV6SGxXeWVGTjZReGdNTnRaNnkrYjd5?=
 =?utf-8?B?KzIyUlJpVzFMY2tpc3RFN1hXdm80WlBabVhobFVNU0NjQlp1and5RXlhTDVp?=
 =?utf-8?B?ZmJtMGwreDhKVFZSL0M2UU1NajVWL0h5N3BiZzhPaWpROEdCRFJOelRqbWFw?=
 =?utf-8?B?RmIzSCtiN3RhaUpyK0RXRXZWOWxma3BCUkVBbDQ5N2VISnJYQ0xZRVNBanRD?=
 =?utf-8?B?N1k4ZUhQcEZBTkRualN5VnJoaHcwTjRQejh4NlZydlR1RXJpakd5TERZNDla?=
 =?utf-8?B?aW93SmtjVmcwTVg1SU1tU2U0MldjMXBrdW1jQ0xtMjMyQityY1hCaEJCamNh?=
 =?utf-8?B?Nk96OFJCT0lra2N4cnZ1LzFkL3grek5nRzIxZHQ3MlR6RVpsRW5OWHVUU0NS?=
 =?utf-8?B?S1ZZM2V1aTVhaHBLTnkrczg1K1pmV2JCQ3N3Zm1mNFFkUFdGeXQ0bWhTNyt3?=
 =?utf-8?B?dnFYT1lFanZYNEVjblVhQU1oVitxRDgxT2VyandqREYya0hjbGR4eWcvUjc1?=
 =?utf-8?B?dDVzQko5aVRKUW8yVlhueFMzNVdVNm5xd09NUnluVEtXZEtGSUtiNE83OFQ4?=
 =?utf-8?B?NjhpMis5YjBwclAyeDJ2VWdBK055eXpnOEJWbWJLdmV5dnBLbTJRL05zbEJn?=
 =?utf-8?B?UFZYWFE4T1ZZaWNyaFJQakx3c05vQWY1MHYrL2JwWmdWQjBqU2FwbGFTNUJJ?=
 =?utf-8?B?UVdqUHRlZjhYTENrMEcrUWlid2MwWjhtaGFBaUJRb3JBUU9NOVZndWJQY2pn?=
 =?utf-8?B?ZzVmd1YybEluN3Y5YUExaWRzbVQ0YWVNR1RLOEdZczZLM3VWL1VsSmVXUGJ0?=
 =?utf-8?B?bjViZ0RIMWxHSk82SEZWUkg3WVBtNmp0dndYcGpiK1R5ck1IQWw1MTJCN3N5?=
 =?utf-8?B?NnNDSHdDaDlnL01xNkV0NFFrZlMyQTRtbnhnUHBFUnU4NU5RUWhYc1dqbnR0?=
 =?utf-8?B?OGdFSUlyNVQ1alJYZkJrSi8vSXd6SUlGa1gyNDBuUTNWRS9qOXVPRitJSWNZ?=
 =?utf-8?B?SmJpZWExVHlVYmVjYk5mZ016SFMyamU5TkRDU2VjZk9NSW1vL0NvelZjbW85?=
 =?utf-8?B?ZEtZaWxLYWlvT1IyWmNabnFqZEpxd1U4VnNoODNqZG1LamRocS92M0lzdTZV?=
 =?utf-8?B?a09OOWt5TTY0SkhsUmxRMDIveldNOUFBV1ZLZS9tdnNrRGlVUzNYUlQ0cGY3?=
 =?utf-8?B?SDF6ME1qRTIveXJ3ZHlQSXU0RS9sNEFPdjRRYVE5Rkxaamx0TDZFN3B0em1o?=
 =?utf-8?B?aDAwbVU4dFpoNThCVzc3TTliaHg1NExXWXdramdtRHoxcEgxK2RQNDQwMHNh?=
 =?utf-8?B?SHRvdHVEWWpDTkdzVDNvTEpHL0lSRm1BQk9pQkRobmx6THB2NWw1N2N0WVUr?=
 =?utf-8?B?VTIxZGdIVGJkb3plOEJUZ0RKWHM3amR3dStmSTFybExNZGZEajNweFo2OWJX?=
 =?utf-8?B?WmhrdThTZU1ERVVkMGpDRlIydUpMZzBTZHJ3d2ZLNm9uMnd2LzllcHJra1hS?=
 =?utf-8?B?U3c1aC9JTkYzN3I3b1RRd2tzaGVLMSs2VmoyU3BJa1ByOEYxM1BqY3dKV0M1?=
 =?utf-8?B?aEZrellqQWZ2Yk5kTzFQeTFlTHYyZ2ZBYkptWi84L3EzWEFnYk05WlNlbVVz?=
 =?utf-8?B?RzJENDQ3SUtEanZ5UDNlT2pqelR3NGUwQVNCWTA5bzNscm1qeXdsOWRwNGNr?=
 =?utf-8?B?c0cxalBBUGxqT2xOTmdZZk5JVmY3T0JQK29leU9KYWFtdXpKRVJaQ09pbm45?=
 =?utf-8?Q?FYfyW3eHsV3kIU1hPVRVUuz8i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 568db997-547b-4c5e-b772-08dc8c68307b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 11:50:30.2268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPP9H1A72xqxvTx8YO/Y8O3w4TZ7fFGq4MlLD2W7BR9+ffCwuStmmQCmmoJv/EKE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7122
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



On 6/14/2024 4:40 PM, Jane Jian wrote:
> [WHY]
> sriov has the higher bit violation when flushing tlb
> 
> [HOW]
> for sriov only init XCC0(lower 16-bit) for all XCCs to avoid higher bit violation
> since kiq ring is always local, local address without XCC ID is enough to be sent to the XCC KIQ
> 

The description is incorrect.

Bits 18:20 represent xcc id. To guarantee all paths pass a local
address, you should just strip bits 18:20 in kiq/rlcg read/write
functions rather than here.

Thanks,
Lijo

> Signed-off-by: Jane Jian <Jane.Jian@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> index e14acab5cceb..4e38a66a52f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -537,29 +537,36 @@ static void gfxhub_v1_2_xcc_init(struct amdgpu_device *adev, uint32_t xcc_mask)
>  {
>  	struct amdgpu_vmhub *hub;
>  	int i;
> +	uint32_t gc_index;
>  
>  	for_each_inst(i, xcc_mask) {
>  		hub = &adev->vmhub[AMDGPU_GFXHUB(i)];
>  
> +		/* for sriov only init XCC0(lower 16-bit) to avoid higher bit violation */
> +		if (amdgpu_sriov_vf(adev))
> +			gc_index = 0;
> +		else
> +			gc_index = GET_INST(GC, i);
> +
>  		hub->ctx0_ptb_addr_lo32 =
> -			SOC15_REG_OFFSET(GC, GET_INST(GC, i),
> +			SOC15_REG_OFFSET(GC, gc_index,
>  				regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32);
>  		hub->ctx0_ptb_addr_hi32 =
> -			SOC15_REG_OFFSET(GC, GET_INST(GC, i),
> +			SOC15_REG_OFFSET(GC, gc_index,
>  				regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32);
>  		hub->vm_inv_eng0_sem =
> -			SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_INVALIDATE_ENG0_SEM);
> +			SOC15_REG_OFFSET(GC, gc_index, regVM_INVALIDATE_ENG0_SEM);
>  		hub->vm_inv_eng0_req =
> -			SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_INVALIDATE_ENG0_REQ);
> +			SOC15_REG_OFFSET(GC, gc_index, regVM_INVALIDATE_ENG0_REQ);
>  		hub->vm_inv_eng0_ack =
> -			SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_INVALIDATE_ENG0_ACK);
> +			SOC15_REG_OFFSET(GC, gc_index, regVM_INVALIDATE_ENG0_ACK);
>  		hub->vm_context0_cntl =
> -			SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_CONTEXT0_CNTL);
> +			SOC15_REG_OFFSET(GC, gc_index, regVM_CONTEXT0_CNTL);
>  		hub->vm_l2_pro_fault_status =
> -			SOC15_REG_OFFSET(GC, GET_INST(GC, i),
> +			SOC15_REG_OFFSET(GC, gc_index,
>  				regVM_L2_PROTECTION_FAULT_STATUS);
>  		hub->vm_l2_pro_fault_cntl =
> -			SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL);
> +			SOC15_REG_OFFSET(GC, gc_index, regVM_L2_PROTECTION_FAULT_CNTL);
>  
>  		hub->ctx_distance = regVM_CONTEXT1_CNTL -
>  				regVM_CONTEXT0_CNTL;

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43603CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 20:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5DBC10E9DB;
	Wed, 10 Sep 2025 20:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YFQjoPe5";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A98A10E9DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 20:13:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzS16qe2l+0fzuVAICEbOGv4Dk6/aA/tY60VK9wrUrUTA6DTkkhk2jlqSvP7q2v1pt5nfJ7ec7Ep9eA4PKhoWt11/X8r7dJ4Gy1DR47PIAm5PBVz2xWFS90nqCvx9n2rp/SRAshaER/tx0PHrroFnd03a0olReVy2ulksJJcC6e8m8N8RIkmXcb4ysZokhsilblASXF/Qn4mxEtY3iEOlo78W1GTeUOdrRyAPfbqyE0GouoUe9Hh2MB4ucpxq+PVxIBTJwshItjN2Mod7uUMAHHiseiEQpoCA9nTWyUia6Fi/mlsAGL8bI8JoZOKpcrE49rY1PLSCmBz2wjl+awqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNm+5Emh8FNqB9rRmdBRLmi9tJMTwBvgPzso8bWTPuU=;
 b=Do1P3DokZIerwVNVVSOlAWUnnA75zVM6p/ne2Pb9kOHUqTKYuQLcF9UvJ1th2DBqkTmU6i3VpRmvRuARAgznN6IgNDDsUN0MDASnpFC/QSraK+VNVhMg0geyk3pEe0zeBbDyePcagovQ+dJeFLok15j2jfu1WtHW/T9iV89gRpBvW/2msDnAKk5q7+xfiZtAx7EfAGP0ADVD+cvkBGxVp+EJi0WUKwV0OetrVvHMHMtpmuaimQtL+y3eCLHgVQQqVdtHmIt8maF1DZDQVqcVpZefSWpMW7CodJiT0GpA55L+huynwZxLiUAzIAPLsbBsSARWGx9LSu2Q9AXN3XzYIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNm+5Emh8FNqB9rRmdBRLmi9tJMTwBvgPzso8bWTPuU=;
 b=YFQjoPe50r95IPxz5/ndtjpJ97g/j4P1xkmEks5Qcpo7h6dx68LXyol4GdVuJPLbQPQSu5zLaZ8qs7hR115Yi0vX2MNl5sYvXmIYem+EMSuYmc8CVJqZXWaxF09qvPc+Bk+n8won9U4fs8kRBfHoTao+TjoKchB41OpD3U6xAcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SN7PR12MB7021.namprd12.prod.outlook.com (2603:10b6:806:262::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 20:13:56 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 20:13:56 +0000
Message-ID: <de98c4ff-f35a-ccb0-ab29-79bcc91b347a@amd.com>
Date: Wed, 10 Sep 2025 16:13:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/3] drm/amdkfd: free system struct pages when
 migration bit is cleared
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.kuehling@amd.com, philip.yang@amd.com, chengjun.yao@amd.com,
 jamesz@amd.com
References: <20250908161526.99413-3-James.Zhu@amd.com>
 <20250909204333.103893-1-James.Zhu@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250909204333.103893-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::11) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SN7PR12MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f5e355d-ca93-4428-ac87-08ddf0a691e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlhKelBVRWh3bEtna0tlbE5DNkFZTkJqVkozK0JjcUU0b3lsVTVYUE1IUmZq?=
 =?utf-8?B?ZUhmcktCMnh0akR6UUhHTTd3WmJwR0NrTzhzSWNxazVlU1N4akRpZklhVys1?=
 =?utf-8?B?Y0M1TjFySWlZd09TYkd6dXdFaSt1cnF4RVNaRW1yd1B4Nm83bGFqM1NHTjFr?=
 =?utf-8?B?ZmlldmovUE85d29QUU45MkFOVVNTTU5kV296eFN1U2pNc0dQUnRvaGUvbHly?=
 =?utf-8?B?YW83eU1kK2F0VWh4V3JIY2hIaGRqRW41WThMTTh4MWp0cllhNmd4TXVZMzFM?=
 =?utf-8?B?Smo1TFpjM1E1bEZQWmhrTmNNNlRWUFUrclppTnFEQjhETFlBNnhjeHIwQ052?=
 =?utf-8?B?YnJVY0xrUVJQV0p5a1M0TjFpOU1JSEMvUzZXbGxqd0xKdFdrQnhIQUpYZ002?=
 =?utf-8?B?UjQzdjhxTlRRaElBd2IzekFiWk1ka1BibzJUcVN0b1VyMGJGTStXR0x4RUhI?=
 =?utf-8?B?ZUxDTlNSZFhkNmtkbElVNDVBQjRndXVudFBkQXBmSnVRcFRmSlo2SWRLdHBr?=
 =?utf-8?B?RDFYMUxnM1hEMnA5ZW9sRzBLb09SYW15THFIdDkyb245V1FLUWlrM29iQUhr?=
 =?utf-8?B?b0Jwbk84eE9LN0tuMkgxOG9aWEdaL1dLQytLVWI3MTZEc01tOEZVSk82TGJI?=
 =?utf-8?B?ZnZyZUdKZ0VJTE1CYkFLSkRFeHVGOE84eUNVNkJVVlJGLzY1ZGdvODJ0Q2ZW?=
 =?utf-8?B?ZS9vbHpmTWlQWFVKRTl2TEJ2ZDI4TmJPd0h0bmsrS01KYU5XNmF5VUFUUkti?=
 =?utf-8?B?MlJLUE02a0E5RXBNN3k3aDlDa3JkSFFTWmhOMTY0ZE1SWE9aYzAzN012Ym9p?=
 =?utf-8?B?aDlZMUV5bnB6SVA4aWxJazhyOHQxeXo1VzRCbkZ6WGRpZDNrZ1BnYjFYdm9y?=
 =?utf-8?B?cXZuWlRTbzluVVBIM0ZUTWdBZXlMZ2VpVDl4b3ZHc04vZkRlZWlRZUQrUFFW?=
 =?utf-8?B?N2hlblZCeUhRUGIwaDh2RFNOV0JCbU9lTkk0bmh3YmlKYVJMeFJJeXd3YUNE?=
 =?utf-8?B?M0tZUGdsMkpjUFZ3MVVkeVIxNCtsaXovaWllbVRPQ2hUZENMdktHdFZpNUpl?=
 =?utf-8?B?MlJXQzd2WXhMb0ZUaWlhVlRpRHRDNjRpVWRUMUtnY3k2S3Jua2RXVXEzYS80?=
 =?utf-8?B?c3U0RjlmVUhaWGRVYXROVWRHa0RUQUQ0VWNJTDNBdHNpQzFnNGo1emNCUkN6?=
 =?utf-8?B?TzlNTFlpOWpzbEtJRTd0Nkw5TEpIeHk3aUhuYktIM004bEgvZVNqSHVuM2Fr?=
 =?utf-8?B?R3F5akhENFJtMVNzeUFIaUxnem02N2xWbXB5TzdVa1JjcDN4Tzl1NlJsckxh?=
 =?utf-8?B?S0RmQ1I4LzJ2VG56YTJjeGxHMmx6TExMTlFKZk02MFl5TUV3TldYTW5mcFpB?=
 =?utf-8?B?RDdKKzdHTS9ZNjBncDJtdnMweTFGZWdObzgvUmNvM1p4eFdWeUEwa3JuVVJY?=
 =?utf-8?B?VUV6UjFIVXVhSmV1WjFPYmZQOVZUWnpZdWNCK2szRUkyVVlRM21adjFod2Vm?=
 =?utf-8?B?YlAraFBTNXduYnRMeHliRFdZclMycjJKU3o2SVo3WjNJand3RXkyNXUxeXRa?=
 =?utf-8?B?a2JrZzA5Ly9uaFRpTnIwaHV5UHFFbWlFS0lCdThoRE1KcTFBcllrZHpLc0Ny?=
 =?utf-8?B?ekV4LzcrMElFK2JFOFVkRjlDY0xXNTNLTG85aEF1bk1VeHpMK1FvcHlCMm82?=
 =?utf-8?B?dDRDa1VRR0haVW9vRnE1MysvTms1T0FXTVZVMlRWUk1hSmtNY25jL3pSWWda?=
 =?utf-8?B?eWxTd3dqUWxBdWQ0SjRveFNMb3g1R0dFM3ZUSjhhNWZobjMvZWVGTWlpUmVv?=
 =?utf-8?B?OFcweVJNV0MxQjEvaG4wbmxkY08wWWRmUGhXazljTXJSSjFNWDFpWG40VzFS?=
 =?utf-8?B?ZUpPR2FmVUowa3I5VlFadGJqdW9iQWZPVXZyVmZDZ1lOaFR4eEFReTdnS3ln?=
 =?utf-8?Q?QlN4Od2gQBE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGROU0JSbGloTjhpK2RBOUk3YWcvRjhMM2NBNkovZlowRldhcUhWdE5XdVR5?=
 =?utf-8?B?dTZWSjBzTGVkMGx6VUZzYXNMK0poMzF2NTRuY09CUnNsRXJnMG83Qkg0cGFE?=
 =?utf-8?B?MGNVNmwwOXFVTGV5aU55Ull0bG05Rm1vNDlGcWpRU0JUM05Qa0pDdjd3cnRw?=
 =?utf-8?B?d1ZLbGZNbm16c1lPNTlpTXJjMnZZV1E1czBwUjIvMnFyM05XaUgrc29yMUJX?=
 =?utf-8?B?Rkw4ai9aUHNjNTg1TU5Yb01udHdjMzZXdEhwdGZOUHhNYk4xNG1hNUE4Z0ky?=
 =?utf-8?B?NTVlakJ1RWprc2NPZGRXV2NSZjhINFJUTEtNWFZ3MjhqN2cwTVZ0RTdJUXZ3?=
 =?utf-8?B?WFFaUUhET3czaUlnTC9OQjBzM0x4Si9yeGg5TytxQkx3RjFaWmxnY3BrSmhR?=
 =?utf-8?B?cVF1aG83VGJRVTk1QnF2SXVKZlRhNUtEaUZSMURFSEVNcnRWd0Fsc1BJaFlQ?=
 =?utf-8?B?cytPSHdpOSsvREc2eE9aOXY0a3d0S1FUYnBxT1d2SVl0S2hyVHFna2I0RHBx?=
 =?utf-8?B?UGthU0w3YitiOE9nZFRBTmxxd2NYdkViekZzN2VxaDVtVWRWb05RRnY2Wjcw?=
 =?utf-8?B?MUpQQi9RcmZoWUZvcGxXMHQwYm1aR0o2ekw1SC9sOStYa1gxbkNMSkVlenZx?=
 =?utf-8?B?bTNPNjZsalV6WjNKTXF2V2lHTjQwOENaTTlKaTJTVFc5VzZRaWJIeTVBdWY0?=
 =?utf-8?B?anVML0hzWFk5VEJKK2Fhd1YwUktIbFFkbEdjNTBTREFVbDkvL2hQL2t1blJm?=
 =?utf-8?B?WEdJeHRwN2NOSkNpOTdqM3VIdjc1SEpOSHV1dnNoc0dWaDlOY0RsZDc0am03?=
 =?utf-8?B?b21jK0dndU54dFZOSHNoUEY2Rk1RYWZoTmtmZ0lwb0JKaUdmQWYrTjZneng0?=
 =?utf-8?B?eXJVWlMyZ2EwY2tjSFZ0ZGt6TUVJdjZKK0lqZ3pDUUlUOWcwUXdOODg3RU83?=
 =?utf-8?B?dkZKS29SeTFhdWhReDROM2krMDNRbEI5b2FHdldHVE1RL1N0SXN6dTJWR2lJ?=
 =?utf-8?B?WjZ3ZjRLN1JCRThjZk8rYjFTb0JYdWM3TEpUNjh5YThSVm9uQ0ZVRHBQZ204?=
 =?utf-8?B?K3FZRElReEpDOWxITzhiNzU3dUlRNitNMTB1NWhnQXV4MTdQaTUwOEdFL1ZW?=
 =?utf-8?B?VjJKSHNFeGsrS29EUVE1dFNVSmdha2NGQWo4RHJQY1YvV0l4QXN1d3ZHR1N3?=
 =?utf-8?B?RGN0SVRCelVMdVJJRGlGNHpUY1UzVHp6RHRuUzFTd3VGck9pU1VDZm13RHB3?=
 =?utf-8?B?YjRmd0p6YnBIUGpSNGVSNTZLUlVjYnNsWUR1Wko4VE1GL3ZkbWU0c0gxaFJM?=
 =?utf-8?B?R1RWM2RyNVVoTGpXM291akJVek1hWVNDZmpqdWZDVEN2ZHlQUCtDRkhNNTRY?=
 =?utf-8?B?VGJ2TlUrSlJFdDRJaTYvdW04M2h5NWV4VXJHaUZFcHNXa2twUzRuWTNmMlFJ?=
 =?utf-8?B?Q2RkUVY4d05xSHB1bEZ2WlpZOTlNT1NOOGdlVDNuejF2TkpVYU5RUWNSeUVW?=
 =?utf-8?B?YUdoWEFrNzFaS09iek53R2lQd1cvQUMzd3VsdmJJaHlLUVBiR05FMGpVTnUw?=
 =?utf-8?B?azg2c29WTjVpdlNNTkhQS2dqSnlQU0ovWjhMWU8vUjBIZm5KYlJCUm94OFFx?=
 =?utf-8?B?QjNTcWtINGFLcjFTUkFweTExcGJpbnJ0MS9rVkVkSU9aWmtpTWdZSCttZU1x?=
 =?utf-8?B?ZFJobkxvTnVYWE1Ha0pxc0RQSlZZQTArVnovV2dnaXdKc3R6ODRldkdBVHd6?=
 =?utf-8?B?K3J4cm1IaUlIWTlyUmtTZmhxTzFHbTltR0FzWVJsSUsvelQwVzQ0MzhCY1gw?=
 =?utf-8?B?UDNoT2RHQlNBYlV6WVRJZFI0ZTZYOGQyL2diQUdycGZUMEMrTFNReFlpTXlm?=
 =?utf-8?B?cDUyaVBYaDMwZ0pja3BrN24yZnhBRm1tQ1RFdmFWOG54RWltaGhXNGxPOFJa?=
 =?utf-8?B?SGJZYmU4TDB1NVdCM002dWFwUFc3NTFHNXVrUUtRRXJFK3RoQ2loM3JKYjA0?=
 =?utf-8?B?Rk80RU9OaW5ZdVRSVnRXdXJxVGFTSDlLWHFjTTIzajdnUnFVbXNKVWRxRk9G?=
 =?utf-8?B?cDl6Ly84M2c2QzJrTXcwN3VDUlJNK0NLUkNuZ1NocjI1TUQ4dnhvUk5HeFBk?=
 =?utf-8?Q?8NXg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5e355d-ca93-4428-ac87-08ddf0a691e5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 20:13:56.0858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRsv1/2iSm8C6q7zsU0AOFwK4i0VLN66rkh88srXlFju9bMpyxbEiwqzaMGz4t4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7021
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


On 2025-09-09 16:43, James Zhu wrote:
> if destination is on system ram. migrate_vma_pages can fail if a CPU
> thread faults on the same page. However, the page table is locked and
> only one of the new pages will be inserted. The device driver will see
> that the MIGRATE_PFN_MIGRATE bit is cleared if it loses the race.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 10e787e47191..1a30764aa91b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -266,9 +266,13 @@ static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
>   	unsigned long i;
>   
>   	for (i = 0; i < migrate->npages; i++) {
> -		if (migrate->dst[i] & MIGRATE_PFN_VALID &&
> -			migrate->src[i] & MIGRATE_PFN_MIGRATE)
> -			mpages++;
> +		if (migrate->dst[i] & MIGRATE_PFN_VALID) {
> +			if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
> +				mpages++;
> +			} else if (!(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM)) {

just notice migrate.flags is only available #ifdef 
HAVE_MIGRATE_VMA_PGMAP_OWNER, check if this is system page instead

        if (!is_zone_device_page(pfn_to_page(migrate->dst[i])))

Regards,

Philip

> +				svm_migrate_put_sys_page(migrate->dst[i]);
> +				migrate->dst[i] = 0;
> +			}
>   		}
>   	}
>   	return mpages;

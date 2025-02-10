Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A44C0219D
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 13:07:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CC1F10E520;
	Mon, 10 Feb 2025 13:07:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1409OG8R";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B274B10E520
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 13:07:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiUn7S5k96B5zDV4WJjxQUC0uyxHld/wZbQrqlgjClVx1MN8pbFU+RUIjy4Q+gbAAj52DpW3FO86NyhFGYd9WsmyOMbCuGBulKVJ/id5kud/xgCbGKJKgB730rn9W/QMVZTAFcR42KhQ3WlG3Of9tCJBFfKil141/7GpAr7XkKOru1sfKfTxsUOLO5i/g5wUOqsszsGQ0KrqAgTUFIMrT2mFwsj3hIXRcPrXESyAitMvM7/VB9kAC5AUrgntcLr4c4oA9znAVPySZ8PTVG8gVuTlfzG9yD4bmlz0VFYplYYR6ULa7zJRIz2HRr4+rxcbI8W984Cyj/HKzjta8eK6gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeSDHSAnojth/Vw0j3hFC20Kyb5taFHBksG11EQ3HnY=;
 b=jSZ3kSlmO4N8g+MNTx91vNgXWVl5nzIik8/aaSgaAuJviAsxBr3Pgqkl28o78LgU79zMX2rA0x87eQ8qwrhePrU+6nNeWms63TmImHrid8Djp/wgELdei5v/QG34PGQp3KwbsCm4ONZmNO1QEHGyN6qDe7VbQet+2jJ8VXfW20GpyOy2SrOkrcbqRnx1AXXBk26G0ZuXkk35h+OFOU9n/UcUESIKs45HP74kzeNdgZVK998XbrdHYSc8n3xgzN31NVTfXfSItP0t/I2p2uJbAAZPBvOFWK/sFurwSqq+PMdyqOsoWehLwmHTpjhRgIJ3CyqN7KTzTdri6P+ShRyMHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeSDHSAnojth/Vw0j3hFC20Kyb5taFHBksG11EQ3HnY=;
 b=1409OG8RBTb90qWnR2XO8VoF91w+ASssmPKpClbpl9ss14RKy6XLTmUx3jdSvUC1/rz6QgtMjpby/UHP+MjfVYkmd7BvgPc9aK0ZEMzLg+xs18W0APhAjvMVrxmss7VM85iVAxTkeUq9pOmeu2KSqdJLqDxv/7kBkNQ2Mu+lIMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB8722.namprd12.prod.outlook.com (2603:10b6:806:373::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.18; Mon, 10 Feb 2025 13:07:14 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 13:07:14 +0000
Message-ID: <f71673a5-789f-4b53-a93e-c9d013c923a9@amd.com>
Date: Mon, 10 Feb 2025 18:37:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix missing L2 cache info in topology
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250207161036.60910-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250207161036.60910-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF0000017F.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4f) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: f3076729-401e-493d-1786-08dd49d3d684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWVORXBaSlZPM0Q1bm1xZzFBV3JXdXVxYVVpdU5FV3Vrdjgwc0E2aGdrbmgx?=
 =?utf-8?B?Qzc3LzNZVHM2eVowSGN0NFBCUGJjWUdIeEE5SzhuR1NadkFDMGQzTGcvTlVw?=
 =?utf-8?B?R0pjTXZuS1NtdFpMaUdXMlNobGVjWkdUdzJZc3poZks5N0hCbnRCSy9WYTZE?=
 =?utf-8?B?Ri8yMGRScjZhcnFPTG80ek11VGRvM3lFSWtvYU9jT080dFpEbHE4amU2R3Zt?=
 =?utf-8?B?VDZKMi9tMnlyTHJMYmlxSHBmWTFYcFlPZlZFWGx4d0RpTk5NYjY0UGF6UEo2?=
 =?utf-8?B?R0dTTlVSKzg5QWV2YU1rMS9xOXFuYjR4N1c4NFZpaVZxL2tpcnd0N2t0RVZs?=
 =?utf-8?B?b2RTVnhiaDU4dmlSTlR1NUJoa1VhaDl1NS9tdkpnRGJ6c3NxU285bXdlOTcv?=
 =?utf-8?B?TlVYMVV6TkRaSEFxL2FMWjFDRFIxc0xxODRyNGJueDlTQ05TcmZFcy82Z1pR?=
 =?utf-8?B?R0FpdjJlYVBmeStKK2FOMmtnNW1IZzAxazZ1cVlWZ2dncGMxbnBTMVQxOWVJ?=
 =?utf-8?B?dDVVNTUrdmZpWEdTTWh2MjRyaUlSd09nMFBGK1N5aEIvNGtaTE1zVEl6WE5k?=
 =?utf-8?B?Mk9Jc2F6MVJnczFhejdkQUpUREVzZ2FYcW1RUnRTRko4dG1OWEtuVkp1alI1?=
 =?utf-8?B?bW5yNDZ5alNWaHRQbWxDZTVRT0Q4MXIrU1hUVHRsWG5MdXBkaEN2amZsMjEy?=
 =?utf-8?B?SDA3WEJXUGt5bVdMK1FFNFBMdTBub3dkcFdwaXBtdEtxZkgrN0ZESk03T0Zk?=
 =?utf-8?B?VEpjcGdSWWRoVDRRdExkN1BydkRHTXI4WVlKbGxUL2VJcDM1S0RKTlgxakxn?=
 =?utf-8?B?bjUvZEp0Ly9sQlNoZ2VQNFVHSkN3MG9OWjJ1aDZzZ0c5VFE0S1lxU1BZb0p4?=
 =?utf-8?B?YmZyV2tSYk1ZTlBJRHRXdnpzc3ljNDVHTEFWa21YOGI5MG1yTFFYTmJqVzZ3?=
 =?utf-8?B?UDlZZlhVM1l2eDMyaVE5ZW5nZ0VUamdhSWRCd1hYK0owZHZ3em9UZWNpMGQr?=
 =?utf-8?B?akhLWGN3ZCt4aFJDTDc4OCs5V2VCWTVYZVBvdlBiNGRnOXdEZjlyVCtyS3Vi?=
 =?utf-8?B?aUp1QWtDL1hIZFJnOWo2aU1Pb1JRUWg2MHUyVzd1dktvbHZmVmtDbzRYWnFt?=
 =?utf-8?B?SG5GK3hnQ2VlSW1LWm0vT3FhQU5RdEFFUGxNcFQrbnVOdVhjbEYyUmxzSGFu?=
 =?utf-8?B?ejFGd2R0dGIvSTREQ0pHSUVZN2hSVFQxUGtmemp6T1U5VG5ERm9ZaFI5SzVu?=
 =?utf-8?B?RVFrQmE2Si9JRUEyeDdvbENxc0RKcGZreURmS2JxbzNmWmhGaFR6Ny9lNnp2?=
 =?utf-8?B?aE5zM3ZYOTRQNlR3UnZwNUU1TnRvQ041b2J6dGc5NUVrcERJZ3JsOVVWeE5w?=
 =?utf-8?B?YTZSUUVpVkY0cEJEYjdKVU0wSjBIV0hobFYrdkcwZjZrNXBPS3VSeXE2Rm5F?=
 =?utf-8?B?bXhoVXNiSllyd1gvemxOa2RleW9KUFdOM1djQVFBQ2Z4YitONEFYakRScTBU?=
 =?utf-8?B?a2lTdmZEdG5Vb0xpQ1NuRWVVWXRqRVNpdXBteVcwSDRUdm1ZSFNDdEZMYXdM?=
 =?utf-8?B?ZldKL3RSYnpFTTdhbjc3clRqd1MxTU1zZjlYcERsQi9RMWY5YUczNnpHbUpT?=
 =?utf-8?B?QkYxME9mWTlPQnRhZlR1RzR5dnd2Ym9kaHRLUTlBaE9CU2dsL2d2MS9ocWI3?=
 =?utf-8?B?Yk5ySGx5ZHpCL3JCVThKUlFSUHdGT1lnWTFFb0VjbnVrNEtkM2VxeVpiWjVO?=
 =?utf-8?B?Znh5MlNpWGt4UzRxYjR0YUhuaTBPWmV0NS9QWEdvaW1BdDRTZVpYTWgrOFZS?=
 =?utf-8?B?WCt4QXQxOXRuYmxOVWk4ekh6bXNiS0V5T29oVFM4UmNuYzJRRGRQd24wOWFT?=
 =?utf-8?Q?uUOGVsYRd2uGr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUFtZ1RLSm53V0s3QzZYcmQwMElwRVl1TklmL1RkOS8xcFN3TGNjZ2ludllI?=
 =?utf-8?B?OGh3TTV1YlN2cmhUMWNuTFdoVERPYXM4S3lCRVAzWUFORHp1dUE0MTBtaDJS?=
 =?utf-8?B?OWR2bDZrNTNqSVVCYU9xMVRuMStyNWRCenVyS2FtbFRuVE1IZXNoNWdaRFd4?=
 =?utf-8?B?Y3IxWVI2UVNQWlduWmd2L2xTdmVMMVpQZW5IU3REQzlTWGw1djJRRXZXQVlD?=
 =?utf-8?B?R0RaYzFiSW5EZHVhcm4rR0p4Z3JVZmZVYTY4UTE3aTZPTDVSWVBReDdJNTlh?=
 =?utf-8?B?REIxRUs4UytiQlNodVZpRDJaTlBEK1Y3SGl1aC9nWVk2Sm9xZ1daenJqUklE?=
 =?utf-8?B?aVJyTDNtN09hNEpHZEp1ZHZWdVpsWTBDazFWcjRNZVI4cWc2VVdpRVBlVlR1?=
 =?utf-8?B?ZnNsTDN4NzJXR3grdHdGVjhkZkdHd3hsVkdGazZzVENCTUk0aTdpdUttdXZr?=
 =?utf-8?B?VDdLb3N0NWZHSDBmRElFWUcxbUNXaFdQeFhjOXd4aTRBZ09sbXp4a1dYRS9r?=
 =?utf-8?B?dTFDWWRaVW9uN1JFaVB5elgyblA0OFlPZkk0UDFoUzRHMXoxb2NUNDRJd1Fu?=
 =?utf-8?B?OEZVaXNmL01xb2QxelFvYm1oaUhDTjk1MVk4UFJUVFZvTE9tRW5Pejd1a2Na?=
 =?utf-8?B?blhhSjhXM1VsQWdrZG1tcXRPSDZOSUtMb1pWOGJpQmlCRyt5bEM1TUxTcTYz?=
 =?utf-8?B?VTNTV1A2aEZENEVOMHYybjgzZ0pZdVl0YVJCakl1OXZUQXlqVTB5OHcxKzln?=
 =?utf-8?B?QzJsSFVDZmlSS3dkVlQ3RGJEVDNlTG43Tm5yYnFKVjJwNXo4TStocFhoWEZH?=
 =?utf-8?B?VlNKUkhiWmhTYXE5SXRHNVNoMEp3ektTZGF6Q3VhVFNlejBFUzZmVXg1UmpD?=
 =?utf-8?B?YitWUDVoRmJFditrNTFYODdVazZkZmY5Ukhtb21nUkovZ291OUVGY2dKQWhq?=
 =?utf-8?B?QjdJa09TUTd1N2dNZmZQOG1qbis4ZWV4L1FjRXQ0M2llUnFVZHRwQlpBekIr?=
 =?utf-8?B?Z1pSN0UrVTRoV1BVdUpXQUpQRnFiZ1RNaXJIMFQxNmJRYjBGdW5YeEI4c3ZV?=
 =?utf-8?B?NjZWOU1XWEkyQkVJZmlLNHFrdlJ1U1kxVzZocmsxSVVSMXdHZTArblJKSW95?=
 =?utf-8?B?YXBkcGpBYWxTZWFGMEY0c0U3WjZMZHNKYUprdDZmSWdER01sM3RyeGNDY3dt?=
 =?utf-8?B?Z2w3K1VrT0c1OXlHWlJKK3doNGJmLzVKZzRMTnh3VlltSkJ0V21mSDB3M0k3?=
 =?utf-8?B?RDQ2eFF5TXZ4NW1vejYrMHRSRU93a1A4NUJ4NTNCdnByV1F4cHl6RzVXMVFy?=
 =?utf-8?B?Vm1mZ2lyY2paT1gxOFJRU245MFZLQjdyOVA3aFJNMWJlQWl6MlBhTzc3T2I2?=
 =?utf-8?B?ODQvVDhTVEFoUm5LZDgyVmxnMkN3SDVwUU5OUEtjUVQydEFBYjdKazBNNEp3?=
 =?utf-8?B?QjE3bDdEQnVNaXdqSk55ZGJQVkxWekJhTG5iUWtMSlZGTWlLdDJyM0dLejRZ?=
 =?utf-8?B?emxWWngrdUFZcG5SNk5jcXZTN3dNMWd0RGNhSFpoM2N4bmd4U1dJOUpqa1g3?=
 =?utf-8?B?Z3cvaGluZTY1Mys3Y3VQWkpGV2JqaDhEZml2UDdHblBCUUpYWUFzeGl2NnU4?=
 =?utf-8?B?QnFmUklRdkgvRkJYekVBL1BQbXMwZjByUm5NZUZaZFRZUHpiR0daUjFBM3JS?=
 =?utf-8?B?eW9XRmdTOXhPMG9hVmhGbVQrenJCd1kxK1hVQ3grUk11MUFnOCszWVBORTM4?=
 =?utf-8?B?NEFWQ3lCVVBpMmFSd0U1Z0JxMitNMC80UXJ5SmFPTmdRWXNTQVNCSXJwUVkv?=
 =?utf-8?B?NkFhbm5NYlFrWlNvd01valA5YjF2YktwR0RmTUhKSHRBK0FjTEtKaVJETm5G?=
 =?utf-8?B?SnRmTWIzNEtMNTFKZ0lORHNFYjVRSHNYTVh3ditBQk4rQ2ZVblByNzNnT0J2?=
 =?utf-8?B?aDRhZXdXaU44Yk9TNnJOUnRQLzdpNEJMSmI2OFNtdHVvQnkwVk11ZklCNThW?=
 =?utf-8?B?Sk5EUDZzckJWa1JRYVZQamlyRm1vTGt0b0Q3OUdDVlIzQmk4Y2lNUXUzVDh4?=
 =?utf-8?B?Q1QwRjk4aE9qRmtzRnFSMEhDcWZIelRGT2FvbURBN21JNjM0bFdFK0JkZW1j?=
 =?utf-8?Q?Dfa1dDnlKZQ4M+VBU9zarwVUr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3076729-401e-493d-1786-08dd49d3d684
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 13:07:14.6419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9s9ymPtuBMNkAI/HgPcvFmx8LPTlwWlge4flzrCFVnqBWYane0RD+2bjwZ+V0MTu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8722
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



On 2/7/2025 9:40 PM, Eric Huang wrote:
> In some ASICs L2 cache info may miss in kfd topology,
> because the first bitmap may be empty, that means
> the first cu may be inactive, so to find the first
> active cu will solve the issue.
> 
> v2: Only find the first active cu in the first xcc
> 
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Acked-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 4936697e6fc2..c84010427a6f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1665,17 +1665,32 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
>  				int cache_type, unsigned int cu_processor_id,
>  				struct kfd_node *knode)
>  {
> -	unsigned int cu_sibling_map_mask;
> +	unsigned int cu_sibling_map_mask = 0;
>  	int first_active_cu;
>  	int i, j, k, xcc, start, end;
>  	int num_xcc = NUM_XCC(knode->xcc_mask);
>  	struct kfd_cache_properties *pcache = NULL;
>  	enum amdgpu_memory_partition mode;
>  	struct amdgpu_device *adev = knode->adev;
> +	bool found = false;
>  
>  	start = ffs(knode->xcc_mask) - 1;
>  	end = start + num_xcc;
> -	cu_sibling_map_mask = cu_info->bitmap[start][0][0];
> +
> +	/* To find the bitmap in the first active cu in the first
> +	 * xcc, it is based on the assumption that evrey xcc must
> +	 * have at least one active cu.
> +	 */
> +	for (i = 0; i < gfx_info->max_shader_engines && !found; i++) {
> +		for (j = 0; j < gfx_info->max_sh_per_se && !found; j++) {
> +			if (cu_info->bitmap[start][i % 4][j % 4]) {
> +				cu_sibling_map_mask =
> +					cu_info->bitmap[start][i % 4][j % 4];
> +				found = true;
> +			}
> +		}
> +	}
> +
>  	cu_sibling_map_mask &=
>  		((1 << pcache_info[cache_type].num_cu_shared) - 1);
>  	first_active_cu = ffs(cu_sibling_map_mask);


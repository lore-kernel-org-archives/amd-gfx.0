Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21EFC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 20:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D50A10E36F;
	Tue, 22 Feb 2022 20:01:14 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2065.outbound.protection.outlook.com [40.107.102.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B25AF10E36F
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 20:01:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElXdDtcwzFhbNBNQHLLg4aaHl+aGXjBc7psJOuRcRq/hEBD7BTKsQVrRwQnhcRr61yZjwkIhQHD7GdGE4NJA0TVSa2lIiLNBcUGCVY38h+V2omk/W+AwYK5pRVuyWb5QlnuHhkDYTinMAh2jB0uNLKVoe9R8wL9x1dvwzWmTRAfkmI8agZpEBrcDqeniNo/nlZOltS6s+i3jvjuRoiKtJH84ZHAn0ig8LiZE7FLKAJLd43bR0Stpug34aaLOpBP03jftpkf5Gt6D8mJUd5nQfVecH+ZQtjx7oitIFrVVbhPXzPgVhVJYp11bf0At7ug8RpqOTJ3d3VZimwYsad04uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfMHsjhV7Q7G+XECezTmi5cNQPmVPSvTxbcNA+NROFQ=;
 b=HMJZxW7KvteNlIuIyLMujK5hS+78CqalJvv2NyYdOgjChkJWFQaJdYPc6kDJ7W/THf/QOGjKc1d9ptsi8qdp9qyBGs0Xb9IdohVSuTppo+2ExV0kh6q2P1R7ICAFqf4kVL75rOwzWjyRmbX8JYeBdtEBcpFz8pgliBhDMiT5QBDdZjeb+pWEPFAoGEH5cpjEbIDnDuWzdZ/ZeMoVtLH8GT0VG2TJAESTlXTnfLwBgKFMZKQ64iWpPX3tAhkxFcQWUXI+f+yt1Gvmgc7Qv6XG4ufQsRSQDhnXJ27G264sqzO5znWKUXUANOp0m+s3ybPOaOotAcE3FfxBTwn2VaniNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfMHsjhV7Q7G+XECezTmi5cNQPmVPSvTxbcNA+NROFQ=;
 b=CbH/Zlv+Z2c7hjnSrKHNuDQ9oTkHadOuHq0tqiyFNW3LqiaSB6w+75WWht9YAOM/NGBXLrzLr8q4iFzpB4cP6fuAifmlgYlnWZrj9bFbfwK+5dt1N1pNzHcsCKQm+XyDNe6045M06koxk7qDn1GfDHZaqjj+tlbekS5PCD1inE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB3482.namprd12.prod.outlook.com (2603:10b6:5:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 20:01:09 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 20:01:09 +0000
Message-ID: <e7a49848-05b3-6181-89c7-35aa5d059678@amd.com>
Date: Tue, 22 Feb 2022 15:01:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] drm/amdkfd: Print bdf in peer map failure message
Content-Language: en-US
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <d7422e30-a926-a723-f30c-b414f42075be@amd.com>
 <20220222185531.421535-1-Harish.Kasiviswanathan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220222185531.421535-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53aec0aa-096c-4ec7-097b-08d9f63e11c2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3482:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB34822239BF257AAE03533074923B9@DM6PR12MB3482.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JMgGwN6VslD5nCTak6ZjRcRiZm6h6b49gH6Rlm3q3SwTWG5pmRVjywxleRPDTIwZ/Ig6TXkZCGjPiR8oHkzDXdMcOvyzSueS6lhcn0CCvYfbDLZ5S2OokuDYxPzfX0zVYx4M6qRf1RAth7qah3iBa2t9b++uxaiYsmiMGmBDHZN6vNkggIvRaBhuAT05BB9LIpCceMwJ/Nm5Lu+62xWMxjgW8byxMTp2CmXc0ThQF2GFj2LN5rbzTflQl89SIV1LUGF9IcaH4LXAhc3fjpKyP8Lz8dCPFoi85f3p4Dy0lxSM8Gj0tw2E65LIB68enZwH2mn90nfxalDF33IsJZi3NhNwQUG2iTudICDcK3v1kTP0hS8UkI3eG+2/vuWSMLhMFdy4tqXqg52EO5rTZy1wjuS1O/is+SSer2SBYB65TOSH0YpCY5WmzvmsP5TuyTOi6HUMFUmTwXgYhdyQBwTjK97+GGTSMG5jDrHjGY7j6SLVQ68kBUmU+Ud3yztUYA6R3WWRXWnVRdGlz0mfc3+4gdvPf4T13RLbMOzmK6lv2dVzQ7PkXQoS8ITSz0WGrQZ68KuRWyoxM8BEb+MdQRKPeI7pGph+PrF6E7SmU3zwcMIBGoQkMl1st9CrGcZF0rHrq4GxKiwQggmr83FbApT4XydlnEMHc3z2Jhz0SUdzrFVXWtbsC7NKBA3rCXB/TVjEWr36BN/n96raLEqoLXivMH0R4Z8NbpZiAf+RpdLfk9hYfWIq/ULnFwE8XKflW5X8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(2906002)(36756003)(38100700002)(44832011)(508600001)(83380400001)(8936002)(2616005)(31686004)(6486002)(316002)(26005)(186003)(31696002)(86362001)(6512007)(8676002)(66556008)(6506007)(66946007)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVJmSTJNb3ZBVnJ3LzdvK2xrMTFIZ1NFcGt4Z3EreVp5dkZIRVFJZUlJREFv?=
 =?utf-8?B?Uk9tdWxENVZIck52YnV5bzhBWXIzN2V3b2ErYzdmS3YwTUgza3FnVko2S2c4?=
 =?utf-8?B?dzhVYXBqd3RsZjJvSkVjalM0RGRPaGdlRmEyT0l6cm1iWnludnBOYUU3V2hw?=
 =?utf-8?B?WnlINFJhNGx5ODFpbjNmRkM5ak4za1d0aDMvandIdTA5NEdESzJzVngvaCti?=
 =?utf-8?B?L0J2dklNZG1vclNjYkpPZmNhckt3MHFiNGUrMWpTMmNqV1krbVNVcUNJKzZn?=
 =?utf-8?B?Z2lUVDRFb1VaNmlKa0pqU0hTMnhKa3V2TXo5TkxEYm12eDJ1VFYzZnBoWUZH?=
 =?utf-8?B?ODVmclRKNlJpdDAyeEVkVEkvUG1OcXFvQkhOWHpOeWJRcWpIaEFhdnlIbGVC?=
 =?utf-8?B?R1RucVo5UHJUWlBKZzg5Mk9EN005Y2I2aUlzNW1qNDRycThVdmc0bU91cHEx?=
 =?utf-8?B?OWtJSDZGVkFZVzQrVVVqODhBQkh1dkFJcUFRendpZkN0S0VlSjQ0TldsQ000?=
 =?utf-8?B?dnBxZ09WVEtYblZMeWl3TGdXa1A0U0NmaGZPNkl3VnpybENnNzQ0RThrRmVl?=
 =?utf-8?B?TXVtYllrWmtJOTFsenZDMEVQR2d3eElveCt4TTJtdTJjdjFMMUpFUGJlOEll?=
 =?utf-8?B?Q01mOC90K2VtQ1h3QWtXRVZaRDhYcGNMUjhzT3hpUTUzZFdINE1KNnk1TlJr?=
 =?utf-8?B?bmdHcldaazUwL0VPVkhpa29nSUpublphY0oxWnl6Sm5OTStxUlBLR3NzdGp4?=
 =?utf-8?B?cjg1MkwxVG5yNTdMbG1NdnYvRWM1bmFjYlZRdWJHaWNxa2dEd05BTm1ld3Jq?=
 =?utf-8?B?VWwxblVDcHlmMUY0bldiUUdTc08yTEJUbDN2SWpZK2FvekFpaFZhWDBVQlND?=
 =?utf-8?B?SjlVMS9iVEY5NHNBL3JEYStQdFRxUEF3ZDNUR3NTSlltcDMxblFIWmhDVXE4?=
 =?utf-8?B?cGwxT0hVOXBMZUx0eUFYczlDdmJGTmJ1VU9URGR3K2k4VTZreFlKcFY3QnVr?=
 =?utf-8?B?Z3dxZ3AxTGViMTZDdG1oMStXVi9ra2hOdFpoZXNlSzk4WXZmZkRHVGtNaEIy?=
 =?utf-8?B?VXdlNmkzaG41V1RKTHZrQU45b3E1OGsxaDh0ZDZCbjR0ZDFGU3dQekh1THRK?=
 =?utf-8?B?Smd1dnJvUnBIN2tkTzFZN2FKUEJTaUY4Y21idnI3czhBSDh2aFI4UUR4TTdU?=
 =?utf-8?B?UFRBd2hBQit3M21OSHlDVGpIaFo2Q0VPNFdHYVplTDBrOGtBdVJFbzBOcmk1?=
 =?utf-8?B?UkR5eUxrRmc4cS93NExQTXdDZ0dLaytNZ2ZXck5LSUhwbHAxSzd6YVN4TnhG?=
 =?utf-8?B?TndIdUVMcDkwVk5ReDM0M3NZRGxNMEI3OTh2RzZLc3FyWnBvcTlDa2h3UHpO?=
 =?utf-8?B?VWZ2MW9kTzFWcDlKc2xHQUFWM0dlN3VxZzY5WW9ORzlDL21qbGlZTDNBVmZu?=
 =?utf-8?B?aHBDd2FJZUcvMHZIeGNGOVpMYnRBdk9hT3RGYWV3bnBJOWIrOFZQVmNKTThK?=
 =?utf-8?B?MS9Ub0FPY000OURkYVJDa0xjVGJaTUpPS0tRTTRuNmQ0SU5xUGFqRjUxcS9B?=
 =?utf-8?B?ZHk3dDVFUnFIZXU2RG5yWW5FSGx1d0EydDZUb2RPdGFVWE5FbHNYV0J3TkVI?=
 =?utf-8?B?SUZYaDhTL21sdDdscGhjaHFoZ3hPeEZjaWZHUFQzZXkyOGlQNEFoZkEyYm04?=
 =?utf-8?B?M2ZHK0tvUEZEVWdVUUMrb1h6VGt5dHh1TU9HQnVaZ3VEUjF0ejlHZ2JtTW9j?=
 =?utf-8?B?TFJBdUVwVFUwMU1wc253TTFUNzQ5czlUdG5FY2hpN1NqSmJVSFVBRlQ1cmpX?=
 =?utf-8?B?aEtzWFJscEVSUzVlclFOa2hveGlLZVJDRFl6TWFuMGl5eXhkbmdITU1USUV5?=
 =?utf-8?B?TS9QaG9tUXBWc3FmT0RSRHhEZkRnbi82eG9VZWhhRGVldW9JQVFOWGlyRi80?=
 =?utf-8?B?Ymlqcm9qK3dRTmFaV3RaNUVKSi9ERlJRNnZZVmtGWUYyZ2JTMmRiZFluVXI0?=
 =?utf-8?B?bWhlZFVXV3llWnp5K1Y5VnZyU0JvUS9ZdEduaTBTN1pSK1Vlb0phUU1DbnBZ?=
 =?utf-8?B?Ym9rMGwwbUZHeENUR2N5OGR2VkRzWktvYWJQYzZ3eTRBQVFBdGdPZmhQcDRp?=
 =?utf-8?B?UWVqcEZZb3hPT1pIYWRxZm9iSU5pZGRyNXhKNUtKSFp2bjVNdklIZmg3VkFD?=
 =?utf-8?Q?oV6VMkAE5Ob/1tKKffB38xU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53aec0aa-096c-4ec7-097b-08d9f63e11c2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 20:01:09.7376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EwRt6ZRRgJ19R5LCRzQ8tC4EeO8MeP327VLDXAx3slwi/irUnvI0H+1olQ6fx9TL5rI2/IXS0cKI1+9yjdqMPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3482
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

Am 2022-02-22 um 13:55 schrieb Harish Kasiviswanathan:
> Print alloc node, peer node and memory domain when peer map fails. This
> is more useful
>
> v2: use dev_err instead of pr_err
>      use bdf for identify peer gpu
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 965af2a08bc0..9141b674947d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1215,8 +1215,15 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
>   			peer_pdd->dev->adev, (struct kgd_mem *)mem,
>   			peer_pdd->drm_priv, &table_freed);
>   		if (err) {
> -			pr_err("Failed to map to gpu %d/%d\n",
> -			       i, args->n_devices);
> +			struct pci_dev *pdev = peer_pdd->dev->adev->pdev;
> +
> +			dev_err(dev->adev->dev,
> +			       "Failed to map peer:%04x:%02x:%02x.%d mem_domain:%d\n",
> +			       pci_domain_nr(pdev->bus),
> +			       pdev->bus->number,
> +			       PCI_SLOT(pdev->devfn),
> +			       PCI_FUNC(pdev->devfn),
> +			       ((struct kgd_mem *)mem)->domain);
>   			goto map_memory_to_gpu_failed;
>   		}
>   		args->n_success = i+1;

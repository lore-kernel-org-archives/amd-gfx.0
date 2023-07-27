Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A7CC001E0
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 10:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A2BF10E568;
	Thu, 27 Jul 2023 10:49:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BDF410E569
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 10:49:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipUBhoXmix9INNdmED8Om7VGwEPGmb32n6a5ktE1oVOs0pO+R3ZfQArz/IfLTzUpML0P4sWdkwl0+4wRhYbpfPyvCjOtD8bOXgvDzLUlJWWyw0lJ7kWk9X8AXOImu37jnTCdllJXneZhQounm3lTXQZdkSwQb9fCagAkxrhWK3AM+cm+HmAkDeP4Rv9i102lwcfEtllojcvjWr9D9wb95qQd9VMVHDNjUXMgDAL3HJl7z2bMnarn9RSr7uGQBksGjqL0awBac6rweYelRxCtvPaiF2SkkBzcBskakZXMvIROGL+HmzLD0v3sID26C9pEAI6Ixegz67GimoiwTDtghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOZbf+jj9A79HMdnLQ+K4Z4fI6hsms/fB3A9Shg+Mgs=;
 b=Zkwp198MbwR6kgrIgIrDuNmyRALUWG/EeG3D72WfkHEyba/f5FDr6DLZOkMSPI4B2FwRs/FWyb5CLf8DDO6axXH0D/VEMKw3twlsKirE+VvMbjr2dLQkei3d12Xg2XIMl5fAxbKzCwaFUL4XwqCjSUhmLROLmL4BbAn0QNU1dXinn7zFFiSK2Niuof5u16uT4P6ROdwTQ0FjLQv0atRNPJFClVM5hvSTbXBhL35EVeP1NGVbcUGyJrOLvmfMxNmpzSA9Qr+Xu40g0ZKnpk/QDWh5NZLL+yhHlPxRhXgFq9ertFdH+KAEMa8mQNk2T9Brgl9EIldiyPylFDzq7b++fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOZbf+jj9A79HMdnLQ+K4Z4fI6hsms/fB3A9Shg+Mgs=;
 b=UY74vGmKx7pYJBnd2Fkfx/hHe/O5ZoZx+APd0y8IbMVIBpPZFjCdh5h161T56kt8W7/wFkXjGchD1az6rJp4PFK1eKfUKV3uKjmUGbeX9vk961WOCVJ3oXLy2a/5TjAS56mo3LA75WS/LESuSu/W1s1n1mb81w6Yxm791YDCgRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by IA1PR12MB6068.namprd12.prod.outlook.com (2603:10b6:208:3ec::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 10:49:39 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bd4b:829f:c0b1:bad6]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bd4b:829f:c0b1:bad6%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 10:49:39 +0000
Message-ID: <395e95ff-a25b-1ebf-b809-983c71414171@amd.com>
Date: Thu, 27 Jul 2023 16:19:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: only save and restore GPU device config at
 GPU error
Content-Language: en-US
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230727095003.1959679-1-Prike.Liang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230727095003.1959679-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::25) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|IA1PR12MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: 7383ca34-b9dc-445b-dbd9-08db8e8f2d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1cn0e/bHQK2Eznis6tWLOHJgm6k6LSyyIOaXzLBVa3uQl1JHXJoMQXnynIJVrjdXr2zuL3BatENk/QsYO2x+4kpE+yy3z8+sCgmuSU/Zaz20zk87wso0GkCbXrfNuGoXD7cEgBU/W6WBu/ixoo8/1ONzBzpm4hXTP7AjfuLpPuVvz9LuKLahVULqJdVxFu52DEP1OH9mJAhvOMvHfHDAg25zFJLxdUuZ1JyZ7TtjRTrhhzJbN0RJgNToMOjP8kHPMX4C7qUnTrwPMey7f2or44m5nNS8DI4H3qCECbmws49yu5la1DiUbFaJ0dWg8mYuL7NmjlWMhlVkW2sZYZV++/Bt1b/Rz4f7ymWuAyoH7+gn0p1Iq1IyHy1Je8ynp3M/2zHhhrSk0I9usIf2u6fbkO/PnSOuLEDcWlMREIHynF1ncNxwsWmm518wrZx6wkitVfC64bzOancBpABcmZKFQ3Nj0MBhl7MYahCOD/yKrla/pgK6IOAJpBzU3QQI52Y01E0VLh9TbKM0JuRHKHzaa0ncMqT97Bp+AhHmVMXAXHe+tuM9HwxJkpfHZ+Z/SQ8MtE2fAwgZNRpiDzA3cMRso4wFUblk1oCCR8qvsBUnw+Ag4momzFYKpr5MCmCCFV7fo+cMLFgVpRg5hQNFRMlpYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199021)(2906002)(316002)(8936002)(8676002)(5660300002)(41300700001)(36756003)(86362001)(31696002)(6486002)(6666004)(478600001)(26005)(6506007)(53546011)(186003)(31686004)(2616005)(66946007)(66556008)(83380400001)(38100700002)(6512007)(66476007)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qjl0Q1hlZStraTJJWWxnc2RQSCtEQnNBQnJOWldqUmg3TThaYnkrT2YzUWEx?=
 =?utf-8?B?dGMxb2JRemJUZVgvRC9kM2JHcmNtbGdyVkt0OXZJR1BGZFhqY3h2WFU4T09S?=
 =?utf-8?B?VG53dzgwNGlPamhDbVpVNVVZMmVmYnN5dXhVaFUzRzZBOHZodGIyenUraUoz?=
 =?utf-8?B?MGFEM1AzdVJVdy91a1NudVQ1dDhHVVI2MlhvVjY0ODVlc0czWlhwRjhyRnJw?=
 =?utf-8?B?NzgyVGpnSVhwT0Q2aVJUeTJ4blJyTFlLS2pjdU1BQVRvQUkydXN1aTBiUXl0?=
 =?utf-8?B?dkNINEk5TVRYQkZQTUtBQ2lSbVVzdUVXaVRDUUg0T2diZHo4VW1SUUxDZk9t?=
 =?utf-8?B?QmljYVdOYTAraUd1LzN6WUl1MjhWN2tqYjN4UlljZVFZcCtENllVOUU4Zk9C?=
 =?utf-8?B?YnlwcnhsWENxcnZGTmg3Tzl2RjZndk1aUC9heENseFdSRWpQQTVyYS8xbk1F?=
 =?utf-8?B?ekVLRXpQOCt1dHllWFl6bUxSWHR3YWFEM0o0eDlUb2hFbTlZUXkvZ05JN2Yw?=
 =?utf-8?B?cUdjcFVqbXByZVBQeFdxUlVNemwxSE5PVXJQcWtEc0h5UDZ5NzB4aHFwTTVS?=
 =?utf-8?B?SmhTQ3pNS0lSVDJ5aVl3WXZvQy9GbXNIb0lBYkxpeGNiMXIrWUhPK3RCWTdt?=
 =?utf-8?B?Uk1Dd2Z0L0Nxb1BUY1l0cmxhTmRmdXQxOEgrQlA1MWFEMkoxb2x6dXVBQ3Bq?=
 =?utf-8?B?SFVQTU84V1dmUTJDZG0zbGdCdDNVQUNTMzRkZ2RJMnFvdmNTZjB4TXpmY2lD?=
 =?utf-8?B?YkxpWkF6QmFPN3h5TW1MZ21mOU1XYkZaWkVjWndHdW5ZU0g2cTVJN3FkUFNh?=
 =?utf-8?B?cWtHOHd5OUhIM2dUT0syRjBkUzBSZFVVcjBVdW1QVGZERnNpalVkWE9RVkkr?=
 =?utf-8?B?VHlWVUZkNVlpZ3Q2eERCREFRVXcvKzl6M2ZLT0NFQ1VlN2NtZlBrT0I2MzMv?=
 =?utf-8?B?SHMwcFNvdVluYVhLOUJ6T08yYjhqOUJSRWE0bWppVjY0ckw0RlMxYTk1cTht?=
 =?utf-8?B?dG50bGdYallkS25DMzZMVndoZGU5bDZ6K1JPNlBDbUdOWklNa3VwRFJlQXE5?=
 =?utf-8?B?R1ZTUWY0WnhxSWNrRmxUUFhNODN2TmdBYWZFZlJFaS8xODMyVTdvblpSWmE4?=
 =?utf-8?B?MDQrMzZGUFFEeTlKeHEwUDBnRDB0VVlkT1pNanVYc2RrbC9BWGV0eS9Tc1cy?=
 =?utf-8?B?KzZQVHM4VVQ5UE5aVE0yYWRnK0pLWTVpUTh0M2xDUHZpMUVLVWh3NXo3eUVP?=
 =?utf-8?B?N05nR2dFZnFESldFbEpXR1ZhRGV6ZloxQUZlU2V3Ykoxd29EVXpFN3U5N1Rk?=
 =?utf-8?B?Sks1UUk2dldreGlNM1ZGM2xIWVNKY2RXVU5EVDBmWVVlY2ViVFhHN3NrNzhP?=
 =?utf-8?B?cUdFSXoxdVRjWTFQbUJLZVBNSmVoUFRIL1VvREhPdVpud1VZekJXRkExUVRi?=
 =?utf-8?B?SDc4Z21kVFBIVzVlaWdYcXhrR2R2TFVBOStFOUUxWncwTEVKdXVuNWFvQXJU?=
 =?utf-8?B?U2oxVWNWbUE4d25GWGpqL0sxNUUrRForL3o2anhMYVVrQWVueDI0dHBPZzlF?=
 =?utf-8?B?Qjg4clJDdjNVbUtYUmxWTit1NWRGc09HU05RQ3I0TmNVd2NBUDhKaXIwSmdX?=
 =?utf-8?B?cEh0bGhIS29BQXBpbjFLSnBQUGI3aHUzaUNPRG1aNGJPYzBMTnlpVkFsenRi?=
 =?utf-8?B?dndkeUcvRFZuMDM2ZHR6OGtFcmlpamEvNnZwNFpwYmpOdjFaWEYra3pBSjY2?=
 =?utf-8?B?aVgzdWZveGgwaGZnaFZmSU5ZdjlBN3U0UzFFbm52Sm51eXBVOUZqS0ZZeVhR?=
 =?utf-8?B?K1picGtaa2lVVEo2TUdBYVdFaWcxOWVWWG1SYlZNa1F4SDAreW1mSGNPdDVn?=
 =?utf-8?B?aDNLWUhPbXJ4K0tORitWZDN1Znh0MEt5eEJzdEJ4bjlKTGlQRE1wRXVERlA3?=
 =?utf-8?B?SXBBcExsKys1ck9Vb1RvdjJEWnIvRjdCQjdNdWM2Q2pWS2Z0MG1Ia3pRenJq?=
 =?utf-8?B?cHA2RnArV1dyY0VwWDdSRjhNbEFNMldvUFNQbzUxVWxJVlVjOVJzZXRnME5L?=
 =?utf-8?B?NC95M2xhSEJYbi9OZG0wS1FpN0R1dWF0aUZuZG5hN1BOa05HRXo2MmE1c09m?=
 =?utf-8?Q?Elao9S36kkKXbgltGYmOSBDXE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7383ca34-b9dc-445b-dbd9-08db8e8f2d26
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 10:49:39.6593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZDzbvoX/hiozmIuPVGf8MneViiUyXP3U+49LV1lFq3n91C6RX4MmvdcHQIA+k8W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6068
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/27/2023 3:20 PM, Prike Liang wrote:
> There's need a check on the GPU error state before save and restore
> GPU device config space.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 358dcc1070c5..5ef3c5c49bee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3946,7 +3946,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   		dev_err(adev->dev, "amdgpu_pmu_init failed\n");
>   
>   	/* Have stored pci confspace at hand for restore in sudden PCI error */
> -	if (amdgpu_device_cache_pci_state(adev->pdev))
> +	if (adev->pdev->error_state != pci_channel_io_normal &&
> +			amdgpu_device_cache_pci_state(adev->pdev))

We need the clean state to be cached, not the state when there is an 
error. This state is later used to restore later, say when a mode-2 
reset happens.

Thanks,
Lijo

>   		pci_restore_state(pdev);
>   
>   	/* if we have > 1 VGA cards, then disable the amdgpu VGA resources */

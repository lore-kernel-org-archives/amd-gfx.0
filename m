Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F67C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 00:50:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80CA910E130;
	Wed, 16 Nov 2022 00:50:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B63310E130
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 00:49:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6l+f9H+X31Z70EBBmEqZhB78l9a2eXzNxlSqjC2OIPsD9ZOfnyrY+yBN3sXrVQKZNeaIWEXpTd92PLQ04jX0XQOwge1lRU9DZLOxcwqtC8Qvp+oFmphUHSbTFjJeFxWgGvLhX+UkeUxrIHxCPDcCw/O6ZSJWTwAAII7ExdaHyir8Sx82/HfPpGkiPChn/jCtyKxvZl4RMYsY89/e+O/AIjy25KoeysNKXjOtNOhy/G5qRGWzWFtauVe3DgVUfw9NQYSoDBliONEDP/nw3xnr7g+lcRsaHAzrgb/Wo7MiMKBKyf4SXP4u4TuAYXL4GY3Za/Bw+8aNHvI+apE2VGGuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJ+8OQqTtdpp4ZiPaU7jIbzC+M1UlrsEhOMg1eYON5E=;
 b=VWLku276A20/TmFiI5szdTti+1+ltjb7giiWooxg1r7/NLSg2lKlauotkRsq7RZqDCF1BmQoJeEbUnes4vVqyNytsk7zXSpQRWchHIRge+RQFRosLaK3fXqsIf0LOPdsDbrgTF2RKxQadJKVdNBu/gtlSilcInm+a4sXVGZjqBCbZWcFhnzWsGPOKp6wAnqA9TWEuiQcwts5OMJhXBj7Fz+7XYcG4Fq5cE5Eb9/fjp12ltS9AvdGDmms/eCKdukvRcIuTS0Xn0C2zeJO9tKkwV1N9K5ON47H6Eu4W7ZVZiuZYh697D5opmIG8YVTEQRm+7+6gQIWQYHMS6RAeILeEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJ+8OQqTtdpp4ZiPaU7jIbzC+M1UlrsEhOMg1eYON5E=;
 b=SZTQWbZQEy3EewT2N+IaEArrG7j4UsMudQQU/kKcsIbxEm/EaZYlRQQyRq9x2MgaELUVrrWItQGw2es4k94bGbhczsIYnYNzVhELils2rsxO5NCx+XhhF4wc1CM0bpxu5YzMNkdmKIIvgnbXkEHP4PdtzQ839VWcXOxXLejlj/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 DM4PR12MB6086.namprd12.prod.outlook.com (2603:10b6:8:b2::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Wed, 16 Nov 2022 00:49:56 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::dda9:dc0a:4491:ac2]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::dda9:dc0a:4491:ac2%6]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 00:49:56 +0000
Message-ID: <76813601-73d5-f218-8b76-590700273322@amd.com>
Date: Wed, 16 Nov 2022 08:49:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [bug report] drm/amdkfd: Fix the warning of
 array-index-out-of-bounds
To: Dan Carpenter <error27@gmail.com>, Jun.Ma2@amd.com
References: <Y2oyylG+hW5tMWJN@kili>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <Y2oyylG+hW5tMWJN@kili>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0f07ab-cf9f-4569-49e4-08dac76c7b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kPicE1TdgoH+5IF9MSZBZ0f/TBGcCl6178LZUpfV5/lUe5sCh8j0ljMyi8SKi4ELsjz+fAFYyPfwUXuxzpJqc+hh+j/96T3O+bRxlXdR+nQ6C0Af71fkuGGJ/M3GVxS39ew+tA+h3ADWNCt5eca6aTrNBGAFH3kjxf2W30eDrt7Z7vV2hFLvz5d6gEvLvDeA7bF6r5jfojCrfT8jcTC+c3afg266mJPdD5PPGcin9xUR2yqgYtVbC+ScBKbBy6yCNMGXzjptRjHISkxvefinE9EE7G/HdGUfM02Faz0j6YdMJvtTIfZGJ0EdGSPHNrfIk4OKfstNmEymujXaN27Isa55cZR9LUR+C9F+WsBMxHfpVYNZPeOttPP9PEoLjd906GHe8PVbMoqzHDUiqARnCfjUZ9xFGXk2GqwEne3lD16vETkLSDRS3v02lcZiUKwJfWe2CN8U8NsZ26ufIo+yz5tlethT/giRww4hCqA+V3jQb985Yp+y/pRkNngA4L9i8hMjy8W2ZJww4opWEELsj8SeGLBR0K4Oa1regrhLl6DsGSLI9X/kC1Ha1k8din0eNrycFVjToUwBtACcB1buxUVDT3AjgA8kciQmY+lLbf8GwMmjlCargXGBQ3Rj1pQE6wNMPbFPIeh62sQFliYLWPz+/MVX0KEx5oSZgFAOt+sAX1crwbqNi5tnSqQu0tZpX3/gRSmILxfKLFMa54nWZ+riYxjW/fpGH8L9CW7X+2bmuJbcL2PzwxWv32KpEHmQdnRBe6LOefEKr/0rOvqPsNQut4t6rzCY9o3GL2he5O6AuI0BMU+IUMI8o7lF/SWs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199015)(478600001)(6636002)(6666004)(6506007)(31686004)(6486002)(26005)(6512007)(31696002)(53546011)(316002)(66946007)(8936002)(36756003)(38100700002)(8676002)(66556008)(41300700001)(2616005)(4326008)(83380400001)(66476007)(186003)(5660300002)(2906002)(116466002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ykp3bmRwL3NJV0RQcEtMZTJBQ2thYXZzUk5vZU5zTVJmUmp2QjZvNXpZSEd3?=
 =?utf-8?B?K1BvVWJzcUtFaDNJZVN1SnhwbHBtS3E0ZGYwRFZydUh3cjJMalc0WnAzaDVm?=
 =?utf-8?B?OEpTSkN4QkJHVTJYRGpzaWtBczJmdy9nRmo0WGNQd1lGMXBCNzRaYWU0bGQr?=
 =?utf-8?B?T3F6Sjh0dnQwcnR5YmJaQ3NjME1wSW1zYXRxSktYTGQ4czhkN3N1YXBuYTN4?=
 =?utf-8?B?a3puMTBjbHNvTXlaeWdKbytTYWtyVTFqUHp4MlRTc1pBN29OQ0luTEtYZkJZ?=
 =?utf-8?B?TW5PbVA4MkRxZ044a2dUZzVBbnJvMWpaSllBZ25XYVBMeXhqV0IrUnFYMklq?=
 =?utf-8?B?cEtpUjh3MG9aaWNVanQ0Mm5XblNSVUJaNC9ydFZ4RjZ5NTFmcW1HbmUzS0h0?=
 =?utf-8?B?Wm5XRFZUZTkyalgrYlVPS3hldkhGNFJsNHFhZTZHSXNlalhFTTFQNUVidTZV?=
 =?utf-8?B?S0MreUtxejRGWXpZZk94S1JuZ05mSm1laldKeDZXVlVEdDh5eG0xaTEvRVk4?=
 =?utf-8?B?QnVUaVRidHlEZWNuOVV2QU1Tek5uQ3ZpUnhLZklmeXVXdFBrU21ZZ3pYOXRz?=
 =?utf-8?B?MGd6R2JXMXJFY1lDdmxJNStkaTdIdUFmZWdITjduNDlWQnlhSXNaZ1dSQlNI?=
 =?utf-8?B?ZG9jWG5BQmJSelcyUGN6YTQvNjRWK1FPcTJrbkZMeTZ3aisyUUYvTHF1U0hK?=
 =?utf-8?B?K09WRGNMVlB5UFNBL3FJKzM3QkxJY1FiRDg1enp6SUJXWTl1bkhkdEJNSjdZ?=
 =?utf-8?B?dVI2VWswTW5MQXZWUGFiNzVwUUxWVWgrTGZRRDlpWFhlRUF1QUJwOFA5TDY3?=
 =?utf-8?B?aFhnK21LdlVxcDc1OE9GZ21kQ2RXSWFSTTRqMEl3aXVidGpBM01QNWkwdzVK?=
 =?utf-8?B?alhXaStvZ3lHV1FwQXllUzV4cGVvVnhxSTZXZ2VHTTBiRkhlYitPZ0V1Wldp?=
 =?utf-8?B?dWlUZ3E2Q1hNRXpCQTBtSkpWNVFTOTVONWZ5bjVKRmpxU3ovdUNUK3BxdmNV?=
 =?utf-8?B?d01kckM4eUNmRDBublNUVnY0MmlzbEFsdS9yN3dwRFhXT05MNFpNTHdlYU9F?=
 =?utf-8?B?VVhzQm01Z1YwT2E5TjBHeHExRTZjUE1FM2xPN0hIb1ZsUkR5OWVCdG5IMmpN?=
 =?utf-8?B?VWV5TFVyQW4rby9FckY3U3FJTS9ITFBXMC9nbGMwY1E0MnRjVElKOU1jZEpv?=
 =?utf-8?B?L3ZpM01vb0xaTm9MTW5GUjJBaS96eGkyK3RFVlN3eUgxRWJ1elJzblc4alU2?=
 =?utf-8?B?eHNNQVlnRmwyMjlNaHFqa1hoRThLZ0ExUnpKcHZUUlI3V3VBMzBIR3RsNHBT?=
 =?utf-8?B?cEUyNmRPU1ZNeFl3TERLUU9ibGpnWG16V3dmQ2JSTGtFOXdiZDhuanRyM2Qr?=
 =?utf-8?B?Ync3M3dFR05HME5rSlB4U0JuWHp3YWRCbnV5c1JKejhwOFJEWXdhazBDcGVP?=
 =?utf-8?B?V0hSTE4zeGJraTJITFc0b1BCTHlyN0J3clRlNEpTc05MUllBd1dNL0RNdU1a?=
 =?utf-8?B?TUFEZGtIWVVrcFI1RDVGQUNiYXpldnMvcmFKZzJYZHVQMDlYU3U0OTh1L3Zi?=
 =?utf-8?B?S2N6UTZvUUJ6ZVBnSTdlc3kwbWlyUFJ6NUFkTGhHalJoWk1PbGRjeDN0aHA1?=
 =?utf-8?B?cUhya1NkazNxTnRWMTNnZ2xUUVRlcnRqdU5QYUwvakUyZXpjMXZLQmszUE1o?=
 =?utf-8?B?TkZ0SWRFRjVVRk83K1NxTmVubjVaS0RSMlZrYldNVkxqU21IS2F1S1dxT0tw?=
 =?utf-8?B?U1lDbHNEMXdIZCs0ZjlkVThYanVQMExGbEdxdm9GVjRLVm1HamV4eXZlRWhP?=
 =?utf-8?B?MEpKU1Y1TldiUHl6emFmVmNjT0MrR3ZYeW52ZEdGaTEyS3l0cGxJTHQ4MStm?=
 =?utf-8?B?WW5EWmUzelgrZ0ZSZHVqaS8vUXVSZFhoZEd0QUU0NFFIVkNlRnU2WGgrMjdP?=
 =?utf-8?B?dldlR3V3dmEweW5yR0FDQzNYNDZuM0NjbTAzZ2hlMHRVd3crRGVNUXU1WnFm?=
 =?utf-8?B?eEVGUVdHS3VHTm1xRTFsNm9sSmlSRC83Q1Q5RkZ2VVM5ekR3ZW5sS1lEUUJM?=
 =?utf-8?B?NVhrcHh1cTYxbktVaERFTjdCL08wU0piL2dtMzAwMjlUVW1Kamc0TDV5bnNX?=
 =?utf-8?Q?LkIYrnsLZIRRMevjRVUxGi1IS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0f07ab-cf9f-4569-49e4-08dac76c7b3d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 00:49:56.7636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76rVndkex+lNcf0PVBUeqIajkJ1OCcScIOmYGBco0YwaG8mzFrTsJitFv9sr4I4k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Dan,

Thanks for catching this. I'll check it and post a fix patch.

Regards,
Ma Jun

On 11/15/2022 9:00 PM, Dan Carpenter wrote:
> [ Ugh...  My email messed up and I have to Resend all my emails for the
>   past two weeks. -dan ]
> 
> Hello Ma Jun,
> 
> The patch c0cc999f3c32: "drm/amdkfd: Fix the warning of
> array-index-out-of-bounds" from Nov 2, 2022, leads to the following
> Smatch static checker warning:
> 
> 	drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:2008 kfd_topology_add_device()
> 	warn: inconsistent returns '&topology_lock'.
> 
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c
>     1808 int kfd_topology_add_device(struct kfd_dev *gpu)
>     1809 {
>     1810         uint32_t gpu_id;
>     1811         struct kfd_topology_device *dev;
>     1812         struct kfd_cu_info cu_info;
>     1813         int res = 0;
>     1814         struct list_head temp_topology_device_list;
>     1815         void *crat_image = NULL;
>     1816         size_t image_size = 0;
>     1817         int proximity_domain;
>     1818         int i;
>     1819         const char *asic_name = amdgpu_asic_name[gpu->adev->asic_type];
>     1820 
>     1821         INIT_LIST_HEAD(&temp_topology_device_list);
>     1822 
>     1823         gpu_id = kfd_generate_gpu_id(gpu);
>     1824         pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
>     1825 
>     1826         /* Check to see if this gpu device exists in the topology_device_list.
>     1827          * If so, assign the gpu to that device,
>     1828          * else create a Virtual CRAT for this gpu device and then parse that
>     1829          * CRAT to create a new topology device. Once created assign the gpu to
>     1830          * that topology device
>     1831          */
>     1832         down_write(&topology_lock);
>                  ^^^^^^^^^^^^^^^^^^^^^^^^^^
> Takes the lock.
> 
>     1833         dev = kfd_assign_gpu(gpu);
>     1834         if (!dev) {
>     1835                 proximity_domain = ++topology_crat_proximity_domain;
>     1836 
>     1837                 res = kfd_create_crat_image_virtual(&crat_image, &image_size,
>     1838                                                     COMPUTE_UNIT_GPU, gpu,
>     1839                                                     proximity_domain);
>     1840                 if (res) {
>     1841                         pr_err("Error creating VCRAT for GPU (ID: 0x%x)\n",
>     1842                                gpu_id);
>     1843                         topology_crat_proximity_domain--;
>     1844                         return res;
> 
> Does not drop the lock.
> 
>     1845                 }
>     1846 
>     1847                 res = kfd_parse_crat_table(crat_image,
>     1848                                            &temp_topology_device_list,
>     1849                                            proximity_domain);
>     1850                 if (res) {
>     1851                         pr_err("Error parsing VCRAT for GPU (ID: 0x%x)\n",
>     1852                                gpu_id);
>     1853                         topology_crat_proximity_domain--;
>     1854                         goto err;
> 
> Does not drop the lock.
> 
>     1855                 }
>     1856 
>     1857                 kfd_topology_update_device_list(&temp_topology_device_list,
>     1858                         &topology_device_list);
>     1859 
>     1860                 dev = kfd_assign_gpu(gpu);
>     1861                 if (WARN_ON(!dev)) {
>     1862                         res = -ENODEV;
>     1863                         goto err;
> 
> Does not drop the lock.
> 
>     1864                 }
>     1865 
>     1866                 /* Fill the cache affinity information here for the GPUs
>     1867                  * using VCRAT
>     1868                  */
>     1869                 kfd_fill_cache_non_crat_info(dev, gpu);
>     1870 
>     1871                 /* Update the SYSFS tree, since we added another topology
>     1872                  * device
>     1873                  */
>     1874                 res = kfd_topology_update_sysfs();
>     1875                 if (!res)
>     1876                         sys_props.generation_count++;
>     1877                 else
>     1878                         pr_err("Failed to update GPU (ID: 0x%x) to sysfs topology. res=%d\n",
>     1879                                                 gpu_id, res);
>     1880         }
>     1881         up_write(&topology_lock);
>                  ^^^^^^^^^^^^^^^^^^^^^^^^^
> Drops the lock.  The patch has some other locking changes which are
> not explained in the commit message and seem unrelated to the out of
> bounds issue.
> 
>     1882 
>     1883         dev->gpu_id = gpu_id;
>     1884         gpu->id = gpu_id;
> 
> regards,
> dan carpenter
> 

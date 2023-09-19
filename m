Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462C1CE79A9
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 17:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A917410E13B;
	Tue, 19 Sep 2023 17:15:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FA8610E13B
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 17:15:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R929rN2YnIvDii0wMZl/0+uXD09UQxp1nnsXzx/qPCgInim/X5mahMDIqFwLJm+79mFhW/7Uz+Kq6cevKaT6Iil9WlRltiWr6o/v+v6rVw4HBasQIbURADSAEawqt0OBLh2nikrhdZG/HA0TC+CIA9Yk/ybfJFD/THcSdKMvn7dQc2h+0MGcpvfLJpVI6T9vFy7sH2dLcUcjOBBn6x5EnYubsOFaYEDe2VGx5sh9MQ5lhpqSnoRcII3Hl4mfCGgM+IbsF4Xh01I0Sn+owPqrVSNGFbzsotMJcbKboH9FnZ5QNPtbTkTgvE01PJOJ1kK3GydiKdOCeVEnqSPs+yCnew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAibMYQqv0xhbWOWF7I7YbGtyQvCDQJUWuWIdL9P6yo=;
 b=UidLQY4gKogM0r4qDeaoMY9TpcKdODQOlopR4QWRSwUdtwFRz9LujDTm8nliWPM1R80hIOjVz79To5XLGozgFOjN9Saff/MfQGdCeSbOkL5cgxext+CtIDoc3XJAY+WlHfERXQ5T2rrh26T6IUTfOUuNojG/gVbmgGiwVdv4Y20FVNodVQOj8h7vV+R+8dng3Svh92jEm2paW0nIV4D2OgAM/S38iyNrrQTJ4BPRryskz0jpzQeMvtW0Q9owMCOS8yebMI8vr5fQyP5hixv0UhxSyvbAqXhdwB5ItBSe9/0Wnhlrcl2Wm8mDYv5WpQYJNTN/2NrCq12DUW0gU3hnZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAibMYQqv0xhbWOWF7I7YbGtyQvCDQJUWuWIdL9P6yo=;
 b=wBLmpRMUoC5sR3W/Gf6oW1QOmGrLrndKkZx7EzQzLJQO1qXQf1mMNhEjWvB+k1hrV8UVfROOoHTfIrrXBts/O7RgtxS+bHgU2YWUJi4ou2GyMro45AH3xHManCCPjPxziU6lUiXsATAUPlny1FH0VKyLfyK+xr2e0ZeOUwdLNY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ1PR12MB6268.namprd12.prod.outlook.com (2603:10b6:a03:455::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 17:14:57 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 17:14:56 +0000
Message-ID: <d6cb8ac7-1511-4fa1-0e20-e489911e2dd6@amd.com>
Date: Tue, 19 Sep 2023 13:14:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] drm/amdgpu: Increase IH soft ring size for GFX v9.4.3
 dGPU
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230915193409.18822-1-Philip.Yang@amd.com>
 <20230919141702.12654-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230919141702.12654-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0189.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::32) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ1PR12MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 19165dfd-d940-41d0-542c-08dbb933f284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SRUKLeNIn3hMKsf/I7ZszHLTQ4zZ97bf1q1k+q0XKPNKC95/lcH4swYl1XM8H9iGaP3WH4iDdv7j7tdQtl+pRcA6Vr920XmlNwAa7HKmYQvrthZ3Gos/5vIvlTVf2lXfmsdGZOHAYwk3qiVF2Prp36NhSEWiMMfzerPG6pBbyjNl+CryXF2WkdnkwVrPkiCYgYsmQ2VZ8vXYwjnkBWGk3gKQe96fYJI9+aRjruBOMZKlL4Cf/9BoGfOYBO4tWryqzRBE6dDKXobXo1L1+jR6nMGoclt73DsQ7Hl2l7XdntjPlzIlNq3/X6OKU3l6igGFmDNn9UBulJOD1+7/24puF5eHYoKERTn2P7CHDkVQyQ378uxSwOw++V1vo4U+Ley4PGDa4trw6usU1LgS+Y8KEnrswaNGZTs7eHCBIibZ8nq8OQqnSzukPCBWbOTVBQNjbG5CebXSVv3lAQfw46VAWgtB2UDssss5jZ2FOMcunTXdoZVukKhpgWJdUxRvywWfgqxSGv20Kmd60KKZDK7D6cfPp1JUq9UgCAZF+S5mzXziIGYWLedunxDFF8Mzw0FLki6wWqSTZZX58OO0E0JhiUj5QZRwh/x3ZOoWHnKyRgPePl8rr3zcpx3vF67yWGOOCw3OtUj1dlT8GPIi6NtoTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199024)(186009)(1800799009)(6486002)(53546011)(44832011)(6506007)(36916002)(86362001)(6512007)(66556008)(66946007)(38100700002)(66476007)(41300700001)(316002)(5660300002)(31686004)(478600001)(2616005)(8936002)(26005)(2906002)(31696002)(36756003)(8676002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkpQTmZNZSs1WHZQY2FpMDJLNk5RMXRIWGVyUUg2Qno0bFh5VEJ2elhnNm5B?=
 =?utf-8?B?Z0NCR1JPQmJtS0gxdDROTEE4dWRmWXBYREtxdlNPTlRxSkFBcWFiUmh0VmNw?=
 =?utf-8?B?RW9WS0ZaUFVhdUJTak5jZW9DNkllazlPb21NNi91eTUyV2JSa09iWkFDMU15?=
 =?utf-8?B?RTBPMTViYWJPdkpNWHA5NUtXYlhxbnZqaFcxdlpMRU51SlQ5UGR2QXVhcVAx?=
 =?utf-8?B?dTY4ajVXOEpRYTR2VzI5eUIyVDhrTkdKQVVFUEpwbVNvcXloYmN4SFhrSFov?=
 =?utf-8?B?RjQyNTFQcHR4aWZyMHc2bk4xb2o5NFI2ajVFTlRNNDN5K0JWYlVhYzlNdld1?=
 =?utf-8?B?S2o3UENTNWNhQzRYRm5PK0IvYlFFOFdwT2RHVDBqNDkyZndQTU1kQmFMd0dl?=
 =?utf-8?B?YWVhNk4xRUJ0SjJhbHdTZXFPSGxQalg2Q2doWnRKNkptb3JHYVFaOEVWcmMy?=
 =?utf-8?B?eEJpKzJxcEgrcEppQy9NYmM5VzlkZituUFdXSU1admRkWGoyOEV2c1hpQzZU?=
 =?utf-8?B?dnp0VFg3Q1EwQWFHdTB1RVVhcTY1eTZIVTNmeWptS3FSMGhXM0wzenNoODZp?=
 =?utf-8?B?OGFSUURSOEpJei9GMURvVzdjczNvb201dWtMK290S2Q5Mkh4cVk4OGVuNktB?=
 =?utf-8?B?Qm1LeXdKRndhTmJVY1krbkQxZUhjMzErcUpMSGhrTnJNT1JoRG5IQVIvMFZF?=
 =?utf-8?B?aUU3bXFiQS9UUWx1VUo1K0lqWTgrbzNZWUlKWExibk9OdHVhaFNjSURQZjRm?=
 =?utf-8?B?WjVONDZjczhlYU1pcUtQbW5ZOEtEQXFDYTZwOXdNOU5CaHdVaHZGaEFKV0JI?=
 =?utf-8?B?WHlZcEJCY1BhbUpMQXQzV2hsa2xOK05NY3krVkZUUGtDSDdDVnV4WXk1SldQ?=
 =?utf-8?B?TzZTV0hGdm9vL2NHeDBEckJnem9VaXQ4YVFpL1A3a1NLSUNwdkNaTTlYWFBz?=
 =?utf-8?B?OUovTkJialRxaU9YM2JSUWhvY2F4Zm1HYXRQN08vN1JjT2pLNnFIRVk4cmlS?=
 =?utf-8?B?bkFxQk0rMjRwV2hlSjNpSVM0YXJDeHFtMDd2RUt4UHEyYk1nSmZPWTFSeFVo?=
 =?utf-8?B?dWxFYnlqV3FmWjBWODNLWkJ2bCtERGE5UEdnbVlUVkhlS1hoUmdtS0taMWVE?=
 =?utf-8?B?Y00yczRrNnFhbXhheHBobE9kNlVNWXQ5bE1XWlpsTkZndmh1UStWMnR0cUZk?=
 =?utf-8?B?M3UzQTcyUlJUVUtkLzFLQ2NaZ21zK0ZyNEpLUUlrMVR5QTBtdHdUKzZkK3J0?=
 =?utf-8?B?M01jb2FmSUJTb1liWldlQUhSM29PWUp2NUJsV09WL2NWMGdNQUFxSytJV3F6?=
 =?utf-8?B?YmxiZkc1NVQ3RVRCenN2eFBXcWM0NnM2b1FQM05BaXJyME5UOGdoKyt4K1lu?=
 =?utf-8?B?cFk2cUExMDFBUE5saTRKUklZdmdZRVNuUnN4T2dtbi9FSFd0eitLNGt2SFhS?=
 =?utf-8?B?dkh6bXJrV2dzRjdjNnQrU2Q5VE5nanlmMVBnbnNKaHNZNndpSHl0YUNXa05G?=
 =?utf-8?B?NDNSTzFrWkZuRkZmRmoycXE1My9DcE9PWUM2UGIxYW55ck5rQWNCblFuaHZ4?=
 =?utf-8?B?OG9vMitlL0lxdVoxbkhqTEMzOEl2OTFjMGlubDJBYXBrSjFzOW5HdkNNOTFX?=
 =?utf-8?B?RDFUSFQyRzUyb1Jla3diVTdmUms1aC9YMlFlQW5XZTFNRGh4REc1YmwrRnVI?=
 =?utf-8?B?Wnh5Qm8vYTZGWmsxbE4vU2pITHZJZEh5ZGo3RG5qdjN2UkZNd2w1SEtoMXhu?=
 =?utf-8?B?TG5vbmdXanRmQTQ4UXpiaG5ReDh5YTNmSHhKeGNrQ0hOWUlWNmlCTFpab1Zy?=
 =?utf-8?B?OVhTSVloa2VNdGRvNDdmRWptU3Z4a2FrOHA4VWc1b1ZGVzl3ZFJNWHFsaVdM?=
 =?utf-8?B?V2lQSnlkcXJRV2lsZW8yUS9GakgwcXBwNUlQZ1RheG45RUdwa1UxYytkVkFa?=
 =?utf-8?B?Wm9FMkxUTmw2cXBacXhvdXNPbkJDYkhyLzZFSlpUKzA5QlkvTDdsN0VjQXRN?=
 =?utf-8?B?dTJDUU40QTQ0dnAvK1RYRG9sVWl1TmZkS1lMQlFEY2QyWFEzWCtrK2xIdnhH?=
 =?utf-8?B?Q2FlUnJnV0E3VTNmTjhheU9vQlNSRXQrTUhLTWVZMm1LNlFoNndrZlAyNDIz?=
 =?utf-8?Q?N2koUGZgPyNrRIQbCSb/2nupX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19165dfd-d940-41d0-542c-08dbb933f284
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 17:14:56.7946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oi8c8WpDsH4rjZExXKmWEYKCObOS0fNEv+lTEXGxNlL6pSdVb1hBSjLEIXpTkVLRHo9BZ/Gs8IFGY7b5AUrYMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6268
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


On 2023-09-19 10:17, Philip Yang wrote:
> On GFX v9.4.3 dGPU, applications have random timeout failure when XNACK
> on, dmesg log has "amdgpu: IH soft ring buffer overflow 0x900, 0x900",
> because dGPU mode has 272 cam entries. After increasing IH soft ring
> to 512 entries, no more IH soft ring overflow message and application
> passed.
>
> Fixes: eb3220ab4793 ("drm/amdgpu: Increase soft IH ring size")
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> index 6c6184f0dbc1..508f02eb0cf8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -28,7 +28,7 @@
>   #define AMDGPU_IH_MAX_NUM_IVS	32
>   
>   #define IH_RING_SIZE	(256 * 1024)
> -#define IH_SW_RING_SIZE	(8 * 1024)	/* enough for 256 CAM entries */
> +#define IH_SW_RING_SIZE	(16 * 1024)	/* enough for 512 CAM entries */
>   
>   struct amdgpu_device;
>   struct amdgpu_iv_entry;

Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12870C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 19:25:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D9B60F4C
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 19:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C3D9B60F4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1BBE6E961;
	Tue, 21 Sep 2021 19:25:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B97276E964
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 19:24:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBS9W5BgmPjxmF/kjbIkdPvQmC/1NLmK2w87LxlzqHIYZcLVBoAD25NfsmVQ/c/sZa0pKMWK+u2CVmo2O7UAcEL9ZrbHZ+wPzY3eSfCIWprc1Ln1noqRSTqNhcY9klLApKFo5rm6GHLqgFCxwL2RLasIadtAvEpw/fqxACPsSOnFPrCjdA6qUvKHolIhTPbL5lOnUfjzXh3lrLjyofDZRL/G/LPUPIeAwHwDkTLhRJlJDI0tcNf+NYvbj37K3KaQDokwfUk5lLPrRHBmY1DSUJ9hwJFChOyvzRaMJVwvf/g9Djwcx++t+iqupFORG/ULq2cVwUt5buiv8DVu7tYdwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=lzYVb2A2iW3sHz8vqqh9Ya5OuXb1784WG1ESegU2URo=;
 b=VSJWaUN0h/MQAvK6fQ6UhFHPF60vcyitFw1uh2KPt4q2dPIu6Ru1xyrRJW69PAXJ7E+Pnsk48/R7GbAIabAX/TAydYk5BHeVasWizXX5BcSNco+SDB8IX6RZOvgR/+TaE4ozx1rJ0+mWrY7lG1DwGHMJsCW8QHRVoKwFiC/A4Ri/UTOKCOSQDfdMUzxu4mytOfYepGzjmWSKXP9lplteeiHpFIyRWUXcXXnK4fKo4+mLy089YItwAZbQj/NT60Amwj0VgCP2XCnvgLdulVq2qfb/kFmOyWnTIgSW2vRnQGMYNQSEeNuL8tMQEu2XlOfmeoZDoQUaoQsiFpsRi2ywpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzYVb2A2iW3sHz8vqqh9Ya5OuXb1784WG1ESegU2URo=;
 b=tIUmMg31w5e9WRrOBGCz18MZoCaZkNxk5cJlFls/BwjehLbXiTlVsfwR4aWrTeVBtMtm5N0QyPBEGgTMrVolEMkaWNnT9AVONXPXVLQD+OMt2IDUHPSFrY0EaCg5wOAW1c+Mks495j6XcWQg0DNYw3evb66X2AEMLvzkzO0oVM8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 19:24:57 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c%5]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 19:24:57 +0000
Subject: Re: [PATCH v2 1/2] drm/amdkfd: handle svm migrate init error
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210921185307.25811-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <a0bc09aa-540d-4dd5-a481-6f9805f49b6a@amd.com>
Date: Tue, 21 Sep 2021 15:24:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210921185307.25811-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::20) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YT3PR01CA0089.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:84::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 19:24:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 622c4f9c-9cf8-4bb1-2e4c-08d97d357f49
X-MS-TrafficTypeDiagnostic: BN9PR12MB5129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5129DF5395558591165644EA92A19@BN9PR12MB5129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TCUD1JJuOGi9MIHD1V2opPZ+FnWsw0HygIKCvJObIO0NUp0QIrSF1Jk5IyGRSTlBSU0JcwnZcWvo6yP6hn2vvYv75s1d4TrkvfeVojRXeOimehV4UTTzT0ucHWH4impveE+j811gcqjj4IQllle35LbBdpOR1xSgIkgRqfjVvNj2iEkEXkuapAv7nMgyEsM9Hi94n1WFPd7IWXqnWuq5ks20Nlkga01kF/cQMlpceSqTB/1K0mvUyOjTiWWz4yniyIhQL/536juz0Go5NsJ+5IdmJnzcn9CqKw03EOgq257eF1lR/U+j4e8xHJ5mbMjo94b35Qun3X70cDvPaiJSmEySYiGfoObdu4KrkFCl4ThaufROKIhT/ybpWVN7cW3wnaq+uVWznChP7pethcdmYld750jAu8hsfVWmGSG5rzzvsjK0uK3LDS06S94axKkpL48k72ZaZZ6OdIzmi5uFQcGqJzuXpIMjdyNbThiPOC2nPtb8myLlo4FXQtcSR4qp+OdVRhrtIVMV8Eaeoi7q08tkADNiLG3KSRwqRmpk+8DD2Jf07KBO4n1NBemxrSk9t5reQk32hbWbcR19b1HaKl67wN/iWzuVxjSbUGpbXStgYQs5tKYV+9txgWpJ6NMt/NYA3JurlcYIZEB1Ts9rJbUsFCkcXPygT1DUque4CGDm3syhIzCtH3T7OnMkMzwaVJ6szDShn9sPNiRUxkCK4MDJUo99XI1xVT7a9cwb0Pw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(36756003)(8676002)(956004)(26005)(2616005)(44832011)(508600001)(53546011)(31696002)(31686004)(38100700002)(8936002)(36916002)(66946007)(316002)(66476007)(6486002)(5660300002)(16576012)(66556008)(186003)(4744005)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnZYZEoxaEdzVHNvbVpoK2xucVlta1dLTkhpQWFweFdBbjkyby9OYlRTdXYx?=
 =?utf-8?B?UGNOSFM0bU00cFpoZzZIdjBYTWtxdHJ1UktGSWRWdlN2QXpoY2MvQWRCRkRV?=
 =?utf-8?B?U0tydnphSVA3WWZmaFpSZzRsTkxtc3dxRFlJWHZENktoYzhHMXlVSGVQK1F3?=
 =?utf-8?B?MEo5SzRGUmp6ZHM5eS9uSjlxQlNNMmswdHVSVHI3NVVmbEtZYXo1MmRSTGFD?=
 =?utf-8?B?WGZLUjRzRlUxTVJTMnZWZytLQkRkb0VYODlwQ2JqWm0xb0p3bGFmb0RGN0c2?=
 =?utf-8?B?L2YvNk14MFRheXJtVGZSMmJwb255OUZpaG5HcFkwNDZyYmowSzRMWDFGa25X?=
 =?utf-8?B?M0xhdEVnZU1HM01vc2JEc2h1N2NQQWFkMUNFNFQ2QmM4K2toS0ZNdXBjelFw?=
 =?utf-8?B?NjhVMVFjWUNvUG5yTmRYK3JvdDZ6alpBTDhiTkZkdFBPN1dYVnZZRDErYkVj?=
 =?utf-8?B?NDNoTnVhWjhGM01KQnJKcUlpTnR4N0lzSmpWLytIaHpmdkk2ZEwwUkNmc0xU?=
 =?utf-8?B?cWYzRWViRjdmandWTVJFR1REakl5aGZzT1huM091Qi9NK05xcEZ4aEViSWxj?=
 =?utf-8?B?YUxxRnBoSnZiTkhUWVlTZGtPaEV4Uk00bEErWFRIZFA3bmpSK1k5TVJZaHE1?=
 =?utf-8?B?WXRLQ1NZK1VrRmtkclNhNzF0dDhLcGd4eFMxMzdjRjlYOTh5NnI3dithWVJh?=
 =?utf-8?B?MFZKekVHR095bGhIclh4ZkVGaUhjYlB5UldKaGFHeWJ5bzNzMWlwLzBTcjlD?=
 =?utf-8?B?NjdiL0MyVkRZZEV4ZFN5Q0JVanp3cGZWVVlvbThjOVgxMHd0TU9ZdHNPcm04?=
 =?utf-8?B?MmhzMEhTWG5qV2daelhUUUFQNGxkaGQ1UW1PLzhIQlRjRjE0RWJtaCtrR2ox?=
 =?utf-8?B?ZGxPZHFFN1ErbGh5cGdSM2dKWi9Kc2JhM29EbUdiSXNla3BGSEszRG0wY0xB?=
 =?utf-8?B?d1F4Y1VVb2plWDlCTTBsL2VaMTVqSmovZXJDa1R4V1R3S3M4a3hHQmJieUZ3?=
 =?utf-8?B?OCtXOHd3cFNUQjZEQitFRjdEVFlNcGN1RnhNdVZSOE5DTGtzM1daQXFKTkRZ?=
 =?utf-8?B?VStrdiswNzhkYm9XMUpEL2wwaEUxVlNNL2dpajdrelZrcXZFMzNYMzlBYm96?=
 =?utf-8?B?QlRuZ2ZNSjUxbjE4VVZkTDhndE5xb0tYL0hrTzZWWUpLaTUyalorOFpBTjM5?=
 =?utf-8?B?L252TzJSNWVndDI1RnZzcjhORk9sd0NQeXFCNmJocW52WFpKc2RIVDh0OXJy?=
 =?utf-8?B?czYwN2FFUkQ1bE1uZ1dveElUTFRIUUI2Sk5MdTl0WkVtaVd2cFVBWmFySUtN?=
 =?utf-8?B?QnBTa2dmOFZLSHJBMjlvVjdibVhCMysybGw0QXpNa3cxZGYyMlh3ZjhrRWF3?=
 =?utf-8?B?TENQNDRnRktQTzQvcFhUQUU5NTZDTnB3amZhRTBxQmhPbkZjcHhNRWUzK2Uv?=
 =?utf-8?B?OE13VGhxS2t2N2FDeEIwUkxQMUdQdmd1dXhTcFVNQ3IyMkZ2YldpYUZVWXdy?=
 =?utf-8?B?VnpwRFZqWFM5RFV4L1duVEZwWXBqL1dBdC9KL0wrcFRnMW9lWmZxb2l1VExT?=
 =?utf-8?B?N1ZRdlM2N0tzdmNQMlJqb0ZOVktMTU52Rzl3SjlRQkVsdHR0RlA0WFY5M1gz?=
 =?utf-8?B?SThra1oxSFJCczlVZ3JVVk9qUWd3WlQ1YWlUUU1QTHNWcHZwVVFUVHVxTzdS?=
 =?utf-8?B?UHhMMkpyek5iZmtHU0kwZnZoSXNJTlB1NlFvNURGWUhsMEt2c2NQT1ZFazVw?=
 =?utf-8?Q?Vtxt6HP6oIs7218ZEWg9WDD+FZ+rf56iCkKzNBQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622c4f9c-9cf8-4bb1-2e4c-08d97d357f49
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 19:24:57.2892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpv9naPLEoeeIxCZaxAre011xIytIrl+ABN7WosCBRCJWH2LW2FiJpLyAFnqtadCMggZeVeCq8Jf4rTaK29q+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5129
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

On 2021-09-21 2:53 p.m., Philip Yang wrote:
> If svm migration init failed to create pgmap for device memory, set
> pgmap type to 0 to disable device SVM support capability.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

The series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index dab290a4d19d..165e0ebb619d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -894,6 +894,9 @@ int svm_migrate_init(struct amdgpu_device *adev)
>   	r = devm_memremap_pages(adev->dev, pgmap);
>   	if (IS_ERR(r)) {
>   		pr_err("failed to register HMM device memory\n");
> +
> +		/* Disable SVM support capability */
> +		pgmap->type = 0;
>   		devm_release_mem_region(adev->dev, res->start,
>   					res->end - res->start + 1);
>   		return PTR_ERR(r);

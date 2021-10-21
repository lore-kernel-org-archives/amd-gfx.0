Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FDCC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 17:10:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEFB461A0A
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 17:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EEFB461A0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C5FA6ECEA;
	Thu, 21 Oct 2021 17:10:56 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C8B76ECDD
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 17:10:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehPgMGa7orrHwznkVHhGDAfxoflkmyCplt7abjmsD4bhAvI2FKZe0pLuOCyrwlEZL0xcqDYGq4Ppm1wAQT0P9/yL/srGZ/589x1RATYIb9gfjdLZe6WpxZZD69PUyyXL8WB4Aaf7TFZ4jS6aoiNBaZSaqivNTMNIHFPrCvlBg6cojsA5O6EbvHYB7I4VeznolBb5rJgdwd/Q1QWs26bz2JRD1IpuBtH2XTdSt57YLmgTtqkIWAWxpUd7A39mN1Zn14SdYPGVGtLYK8fLAzndO4BSh5i4aZYmwlAvly+yJ5eHU3sY1uNS2XQFC7IU6eg0RJpvLLr7s11jzR63/Ijogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eU10rx7lt6xeOaDkya3sEFc6G4I7uZdyUVzbLpncUYU=;
 b=PBccBmbSjfVWjRcn52kpxs9SwyGTO2wLhVEsIlPsztcQTcJ0xc+XEOX7YRozml1KwBCGdxwO37zc4P/iRNdI06sC+QVh4Bc7ix3Bnu7+C5oPfzquRO9ZTeBea8a/BBiu6KXkxLkaVbdc4YwF7A3RQYEDZa1oz9kzz/tCSRlHL27b9B0g4HACghr6rORx5/jdNml/8nnJbtaV/TlEBBn4o2BQVF7lrqMRBg0RsYJtZAyjEK+mbwtlNAD0co3OE5VxyylGQbD9WvH6XHeArC6wvqrzAHp8peaC14sZMSdR/9N1PC8UAvjb9gQ6NCIZKpoAsXhq3o+dxXf3lajJ/3RG+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eU10rx7lt6xeOaDkya3sEFc6G4I7uZdyUVzbLpncUYU=;
 b=I2iUFvIk48Ohjf4NFxGkD0kd6WPF6FvQvd52w176rv71Lwfhqjm8K3REJ97+4VVFBmUoRmjOvHQreFWmJOjm62IRcAWq25u1sqeee6I8DzZzVi5rbVIzmkjd676j0aeIyNOQNvglkigszuadT4ak/Ru6IyUkqSCDvBMfSlLrS2A=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB3515.namprd12.prod.outlook.com (2603:10b6:5:15f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 17:10:53 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4608.019; Thu, 21 Oct 2021
 17:10:53 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: Remove cu mask from struct
 queue_properties
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
References: <20211015084807.2062053-1-lang.yu@amd.com>
 <20211015084807.2062053-2-lang.yu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <d8823dae-a48a-d5c6-1807-6e35a073aae6@amd.com>
Date: Thu, 21 Oct 2021 13:10:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211015084807.2062053-2-lang.yu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::41) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YTXPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Thu, 21 Oct 2021 17:10:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a24bfb9-b2a2-46a6-e300-08d994b5bcc9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB351581184268AD0D3A4D675F92BF9@DM6PR12MB3515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K2Mu4/D2S0jr61bCsD3IelXudspPKXVCI7Uo9OI250cLPm8R0wEDuMGkGDL0Ws9dVMKkQdTvxul0zHGVd85hQxeZTg1KkC340p0Q5DTX9phzpaa53zToYmo+b9SNcNpM0vcFZT22Va5q4J3yGd/c/vZRzSE3wJ0qYih79g7uKKEExF8Bb/tyvDKSJhmI80hqcdT62WLRVJCk01cXel3hzej/dvYhlcbA3TDrpMuJKcxnlxVaE+TpIBVHaHFdoRPpQ+mBRKLq33D/UQIcVw7Orny7h0NPQ3d5Dv1I/FAPTPr7Y/56TTAs4qnWmoc+KZkLV4fJCjoDOucc6M5MujXGAcfEoFQ5L0JYnvs9tgswLc63bes8AXMuBSPtSh1ly5xO4wzq/904yEJd8+xrvhOIRTTWiL5TROcI5VnOQQfmaLbSHSl9ZW2ytbz7+DGzHT89FjiEh4wk5E6cswZ575YB1bLXEmK+kIYc/11PCLkrfftDbVVaULIlkPbRRd+2OoGOgu8cgEG9u4hgfnSrjSQ7EJg82f+19pM8fZJZ4Ir1B/RTNU2fRZ4sqR7lqYhXJnYTJV2vxuu+F+kclqqtmyU2kSMdHNafynJp8inxaXHudSc4vRkuwjUbcSX16SYw3Fqpr3X+LlQt6Hr4qSDP8uhdX6CkB8O7THXzdYnYpNFL1EY9NtMfw9moT+cK9hOcSqsamZu+Gty3dz68mZa6fPkz6fd2HNV6klydRGYl2bPHt9FVNv2q82vVLaUgrnsR5E7n
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(956004)(186003)(8936002)(316002)(8676002)(4326008)(2616005)(66946007)(86362001)(83380400001)(508600001)(54906003)(36756003)(5660300002)(66476007)(2906002)(4001150100001)(26005)(44832011)(38100700002)(31686004)(16576012)(6486002)(66556008)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlgzZDBJR0JPbThNbHpENlQ5ZEcvMThrRkxxQ2ZaZVN1WHFDNXEzSWdXMDRK?=
 =?utf-8?B?b1dSUUFkNHl6K2RMbjdLUzhMd2x0ZzljaWQrVHpLSlEydy93a2VhQVRmNUQ0?=
 =?utf-8?B?MmdHcHNXRCs4N1FxVWdlRWxSLzBlV094VG5CRkxlRXBFUWRiM21nSStsajRR?=
 =?utf-8?B?WWY4RDAwQm4yTUtvMk9LMDJQalBaQ0xUeUEwVkRPN25UNU9iclhxS1Rjc2lN?=
 =?utf-8?B?WEcwaTZ6RWhFNUxjK1N1clJHV2o2RWtWTVNVRFppL1dueE5hZlRqWGpLOEpr?=
 =?utf-8?B?ZUtkYkNiYWxYRE0wT1k5N0hBN3NKNmx1NGpKc0J6bmtzRWkrMytTcTdiTjZu?=
 =?utf-8?B?MU9YTFo2d0NMSlExZkJiWkZrdUJQVmllU2RnMmxEM2JuazYwM0ZlcnVMcllj?=
 =?utf-8?B?STNtV0tKaUtpclNocDRGNTRsUUtyUjVHaXVsVkFlSnVBcUp4NWNwMDA5dXJL?=
 =?utf-8?B?MWRzRE1ySENiV01EYU4zdmlkTWVCTTdqaktvVTdKUWVDT3ptYStEQUtXKzBX?=
 =?utf-8?B?aTh0MGhVMG9aWGVNcXRFQ2RBSDJJTmxaRmQwdUpGWUZtN3JrbldOL2FZYVFQ?=
 =?utf-8?B?aXBsd2hkZUZoc2ZkbFNMSVl6Ny9HeFBjWElLRk1Jd1JiOWl4Y25vd1YwNHZE?=
 =?utf-8?B?R0VlRFBlbXhRZWdDYUtqeThMTWVpcFNMTE9BR3BGV3BqTG9Bc0ovRjhjbGVw?=
 =?utf-8?B?OGxrMjNPUFF3NFlKS01uWTZ0UjRLZk1YKzJaSWNEVEVCYVpYUkhIczBZMWVl?=
 =?utf-8?B?OVJhaHh5NlN5TThpeGdLalVCV2FmaVdZemFSS1JWdlFkelgydDZFb25vbEs0?=
 =?utf-8?B?Q1JYYTB1aDNYa3BkeFM5RE9teWlPN0lHWkRVZW85dzBQNHNFQWVocHRRbGgw?=
 =?utf-8?B?VGlwc2hSNmkzTG81ZDRCOFpJODZ5MkYwSFNtVjVpdk94cjEzcTBmZFE4d2E5?=
 =?utf-8?B?ZHV2clZqbFBpdjZnTzNUaGlYSmdLN2xUbklRdnlQb2tQTnpyV3pPMEtTdWxS?=
 =?utf-8?B?aHR3L3FlOGdKNkRlNkoxdVRmUzRyR1ptL3hpcEp2YkJzWFV1eHp3V01kQnhS?=
 =?utf-8?B?RTA3ZXJSQk5CbmNwOGNVSDRpZXk3elliYXZ3T25JRS9qNmNGMGU2WmFiS3Iy?=
 =?utf-8?B?eG1JVTNDcUl0TXRDZy9xb3dTekFZVGl6Y09uMkV0bzRiTjM5TzQrMkRxNzNV?=
 =?utf-8?B?ZjZBUHRheWN0NzYzcHNQTDkvLzZoWU0xZ3VPWVNsZnZmcHlhdk01bmdVRmJN?=
 =?utf-8?B?TXJzZzRQWDFQMzhnSGVjRmYrNzJmVEx1TyswdFFzUm5IZ1J5Z29FRFF1NVMy?=
 =?utf-8?B?b3Z3MXNkZ3B6T0VucW9IdklxYWdwRGIxZkpkS0JFbTd0UnhkTVkwbkRtemph?=
 =?utf-8?B?TFZraENzZjE0eDg5ZzNDckEyb0F6a1luajd2K2xZMXZ4cktNWlBvZUU5N1g4?=
 =?utf-8?B?anRTOXc4OERxNE14c0dUOVRlamE0SktKRWxxN3haaGVGY3lGV3RUeDdTcDQy?=
 =?utf-8?B?dWdYV21BL09BSjhiNXNEZzhxWmUxOG51SVUzMlg4SmJRaHY2enVYZUNyWXdT?=
 =?utf-8?B?aDZsNVBEcFo0cDJrUEFUVFZPeDdhbm5vMS9UakRVUlhWcCt1RHlvT1FSS1Yr?=
 =?utf-8?B?eFpCT3JYMW5pMFMxNEVHQjNPaEVuM3BVVEpnOVFvVWk3M1VUMERucTJhZCsx?=
 =?utf-8?B?SHFaU0pvVVNwVVNUdDFCYWh1TE9TV0RtOGdHNU1DaE8xVk1tNGRkNTFaOFJp?=
 =?utf-8?B?V0ZCT2lZNno5SmJmYXlCeU1NWmwrTjhJWEY4c0VoNTFPNU1YeVVjWHFJOFU5?=
 =?utf-8?B?VnhndTR6WGVWQ2k3SW9PQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a24bfb9-b2a2-46a6-e300-08d994b5bcc9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 17:10:52.9593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkuehlin@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3515
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

Am 2021-10-15 um 4:48 a.m. schrieb Lang Yu:
> +enum queue_update_flag {
> +	UPDATE_FLAG_PROPERTITY = 0,
> +	UPDATE_FLAG_CU_MASK,
> +};
> +
> +struct queue_update_info {
> +	union {
> +		struct queue_properties properties;
> +		struct {
> +			uint32_t count; /* Must be a multiple of 32 */
> +			uint32_t *ptr;
> +		} cu_mask;
> +	};
> +
> +	enum queue_update_flag update_flag;
> +};
> +

This doesn't make sense to me. As I understand it, queue_update_info is
for information that is not stored in queue_properties but only in the
MQDs. Therefore, it should not include the queue_properties.

All the low level functions in the MQD managers get both the
queue_properties and the queue_update_info. So trying to wrap both in
the same union doesn't make sense there either.

I think you only need this because you tried to generalize
pqm_update_queue to handle both updates to queue_properties and CU mask
updates with a single argument. IMO this does not make the interface any
clearer. I think it would be more straight-forward to keep a separate
pqm_set_cu_mask function that takes a queue_update_info parameter. If
you're looking for more generic names, I suggest the following:

  * Rename pqm_update_queue to pqm_update_queue_properties
  * Rename struct queue_update_info to struct mqd_update_info
  * Rename pqm_set_cu_mask to pqm_update_mqd. For now this is only used
    for CU mask (the union has only one struct member for now). It may
    be used for other MQD properties that don't need to be stored in
    queue_properties in the future

Regards,
  Felix



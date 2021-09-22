Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D71C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 08:45:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B63076135A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 08:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B63076135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 133916EB14;
	Wed, 22 Sep 2021 08:45:34 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2055.outbound.protection.outlook.com [40.107.212.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CAC46EB14
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 08:45:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUr4yzffJtQjA1J0ggm0qGYMj0r/w69GIIUvnfhXpwIZrdviqBVVT7fJOngN9BhkoU8ZUtKTWvZmss1GEszRB3URAmPUjMJFt/BJavcJi0hrNOme1B8yj+r6mdOQnPn2EY3H3UBT/h9oKedL+JUJ1TxNQg/B/YTU+TIZrPYKiVUK1rntyPIFRKNQZ7S6vaN29TPA8dGugrFP3wSgsRs6h+HYhCbYtED5Pxlk7cpo0gt1vHUw8COj8+dr38b2LNJcKxn0fs+fDXUuTXXwsc9fr5cpAZLlgHZcbxLKe8yz3NmCqhOeTATWUrqYGVqpj0CHXl/GwmjvY8ic8HrZYxZzvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=HPY2hMm9qdDPOWT84q0WQoWXNe2QsWNyDoR7WkkVM0U=;
 b=BQywQbVl1sydbBtJHvvQHLhi3LJnBMSa7CI0kjJINb49yeXXhL+hWuQbvvZOhVSvlaE7jsfeR1iNx1PK2r4oLGGfWXSBWGjKrVFcJkA7saDGWxPloTL4B1XiP4t99MR5Csxk8gKPh/BmxHLZFnpBN/om/TSmQtPAD78r8zMxh5qLhtZAeAoApkrT4Zr8RKi7D2QnrHsjePOV1uy5zskLVZmrbnvQ1xeAhSjVM2+hS2vGLdLX34OgqUxq0mZpJ1FuRUz8gXjC+XsJJ3r7i/PAghv7EeF9EA++xSaGh5w8/VUsavGujNlnv1m/fQaMIE/RDNpy2HoR1nDe8b7Hhimh3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPY2hMm9qdDPOWT84q0WQoWXNe2QsWNyDoR7WkkVM0U=;
 b=YvMPz8YTkmaANI02FQjBRFzVNjHhPz4631IDglWutVg03h11g4obiHm88Pj/2yfKaYSJqDnYN0foX4Xv0RRhEJrm2nXubf887Sz5mJeJIQepC0aEnzHKbSl55A2cXY3Gyy1IryBQBoo+B6wP0zD8SgwGwGD7fKMStbNPvreBfzE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 08:45:30 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57%7]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 08:45:30 +0000
Subject: Re: [PATCH 52/66] drm/amdgpu: store all instances of IPs in the IP
 version table
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-53-alexander.deucher@amd.com>
 <a79eb161-0076-0644-7165-9c9bd209585e@amd.com>
Message-ID: <8c01799d-b001-81cb-82a7-f159d1c626cd@amd.com>
Date: Wed, 22 Sep 2021 14:15:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <a79eb161-0076-0644-7165-9c9bd209585e@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::12) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN2PR01CA0127.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 08:45:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 177e1e7f-730d-409c-de74-08d97da55517
X-MS-TrafficTypeDiagnostic: DM5PR12MB2582:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2582CE764CEF38F1E03FBD6397A29@DM5PR12MB2582.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lvl2Skelu4XHtzbp9hMPMFIWyCoD7PKqZj2S3hWHorZ4eJReDE/LtZoxx6W5gu+SvcMWVqsLsoIKJAk//a9hgTLLIaERNmKK9gqqNSzwsneXf/DxETcgF1Adq5TZPvdFIJzklDEM9ZKcf5B/BlrZ2l3BDgrnYQi8CvyTyczPUjSfctXQGEXt2ZsmqFuokR4xWOHIrGwgiCVS3bnfAFjFPwy9H2V78TZsPVxnyp9HtmNv0DlW04u/z6O3kZV6gGxZBx1MX6A24e1MpIwVG2AP0BhGR+gGmi2EBInYcp+9ord54RoNCV+iiWnhsTMxSz2o3L8btFb5JqyAuCvS27srcKjmX3Fr3vm2IL6B/BdUDIks3EqDQfxRMOuHKn6qki5EGkK/fu75t4LJtcWiuLM30aNqpKmfSNteCWw0Aus+Fy+H6Bit3yNuzU0CFrpwf7d5H0/fNQocXnC0jcYiHmn5ST4S/vMyuYRMB46zA0LKE/I4msShIS2lSwXpkCyHFXRgeSk+tE7Ze+yAbxz3c/Z6GYALt+LStxnppECb7EXCB11cuTy4AdgoEAvCQL/bv7qgMOuVPKQFX2hz+yoahRB8Ebt5GPAVEiZUju/MzhaMorwhTiYTD1pSNAgGMen6fq5AglCSITRwEHixK8FZZckBI0syf8TiFi8KdVdze7Q5jrDXLQwqz5TKv23GR1oZ26Z2HqrS9AHqu9M1B7dhEBLGhZWH8X8xSmslQQH7aXnhxSA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(16576012)(53546011)(956004)(2616005)(8676002)(6666004)(36756003)(8936002)(5660300002)(26005)(2906002)(83380400001)(6486002)(86362001)(316002)(31686004)(186003)(31696002)(508600001)(66556008)(66476007)(38100700002)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXV0bUhtajgrVzNzMzdaQnMreUdvOW5VMWl1VjdIUDdkQ01mVGFCSkdQSkxH?=
 =?utf-8?B?ZTJ6L1JkV2FxWEpYMVVadFZNWlJZR2JXY0VRb1YwMlg1VnpTK2JTSktYRmlG?=
 =?utf-8?B?TGsrM1NoQ01xTFcvdTNUeG40Y0ZVeUNUdnNGcmkzZ1doNTNZQWcvWHNGS3hT?=
 =?utf-8?B?ajFRQWhuRHZHMmRLNm9jN2VneGlLaVQyMmpDamsrazFyT3kyNWxVNHVLR1ZL?=
 =?utf-8?B?Q01neGJLZ1VWRmdwckQzMlFCcFBhcmRSUERibWN3amlrQ0xwR2hoZTQ5VUt5?=
 =?utf-8?B?d1B2MUpwTG5OMlVqOGlTVmNZVVZjdXlxRHV5SDBNUkZWMXVHS2F6Ullna3Nl?=
 =?utf-8?B?aHFXeXpoZG9qaEoxZ3AvdnRGZmMwT2VWZnB6ZC9BL244UFJDSVNBRG96Vk1D?=
 =?utf-8?B?a2hzVFNpbTBLRFFUSVc3WEcxQXBUNHA4L01FMU8xdzdTcnJuNFVaM242T3NE?=
 =?utf-8?B?ZUZtWkFlOGVKcTh4U2RIeCtMMGJjZ0lXTW8xLzJIYXBPWmtEMmdPVzJvdCtU?=
 =?utf-8?B?UlpBVEhYTTViQlpTTXhxSlFtWGsybXpCcGZGSC90aXFlaEdHQ1EycDlobXRy?=
 =?utf-8?B?K2k3UVcxSDFqSzNyQk9UU3p4RnpIdEhnREhCaFhIaGdWWm84NVNNaUVtSVdV?=
 =?utf-8?B?U0RUUG5LTDA3cWJ5bTVzcnBFbXhvNjdia1dxdk9kV3JLS2swNEdIdnpoZ0l4?=
 =?utf-8?B?ejkwY0x2cWFON3FwWktJOFZZWlRyblQ5NDdvU1k5YWtIVFNPRnpIQzhmeml1?=
 =?utf-8?B?K3V5K24xeXlxZjRibjlmTW45cld0UTZWNnk2NXlidVg0VDdyczFuYWZZMmcv?=
 =?utf-8?B?UklpbjVzbGNLeENRK00rT0JvWk1jekw2TmtFMlBPTm1uUENuNVVNSmZLSzUy?=
 =?utf-8?B?dm41M3lqUUhpeTQ1S0IwYkhITU9wRUYyYytCZWdhMHZFN3ljUkNpVnE4eFN6?=
 =?utf-8?B?OUZXQ05ONGNJZVJUTDQyOFBxZGtlcGZNdjF3RG4xNVA4Z2ZsS25WT044bEc5?=
 =?utf-8?B?dmtTN3BFMzQ4S0FZaXRWeU5RM21HNjh3MDVMTWlFVGhTUjVvRWNOdytNYkd4?=
 =?utf-8?B?VkJZUGNRVnNUZVV0MVVRU24yZGRwN1IwS3YvZ2w0YkJEdVZFeVphSVMvbU1x?=
 =?utf-8?B?eTUybTB2TEIxeUdYazR0cnVDaDE2b1VDdC9NVGJDSGZYa1F1eVRoMytyeEpF?=
 =?utf-8?B?a3VxVEhTcFVFdy9kTUY0OHE0K1luWC9CYm9IaDNUZFp4ZEYxSVR4N296VjNa?=
 =?utf-8?B?bVRnTGl3ZERuSlZ3Q0JmMjQrOE8zUDk1Vmp4U1p0MGw0VnZOYmZheEhPbWc4?=
 =?utf-8?B?TW9qVnQvVUJGOHVDRFFwempjZkVobGF0cDMzYXU2M3o1L0hHTE1JbjViWmsw?=
 =?utf-8?B?RkxnOTI4d2oxSWkxdk0yMzZ2MHJwWGFLOEcxb0FaRDRGcGdDZTlCMVFBR05C?=
 =?utf-8?B?MnAyNWVNQ240ZUQ0VjRsWksxVE9sRzUxVHowUUkzNHlBWm9UQWJhb1E1Y3Nv?=
 =?utf-8?B?cUZWQlE1TEx0YXlmTXFRU1RCZWtxdXZ1dzBRaEFWNmFaaWF3WW5wQTZiZEtv?=
 =?utf-8?B?MThUNXJzU29xTGcwSmpZaEdnS1JoYUl4SG5LODE0ZnBEc2d1SkliZUM5MXp0?=
 =?utf-8?B?R2p5anNFcHVqdlVPL3dJMW9vejFKczNPK1c1d2k1TVppMVJTNFVIcVJkNks5?=
 =?utf-8?B?RzVpOGdPZnVScVBGZ1c2QS9mc0oraGx2MVh1TGIzcXF4aWJYZldBUXAvTzFH?=
 =?utf-8?Q?HH1pgkjXL8KsXJZip2N5MnjEUxkML/tW2U37B6X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177e1e7f-730d-409c-de74-08d97da55517
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 08:45:30.1328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTcwS3K5p934hoitMMGgd/AMnNczuF0M+J1jwD8yl0neDNtkHr8lOdCEdVUEPmtt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2582
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



On 9/22/2021 2:06 PM, Lazar, Lijo wrote:
> 
> 
> On 9/21/2021 11:37 PM, Alex Deucher wrote:
>> Use the instance to increment the entry in the table.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> index e3b4578872f1..572a634f7a1e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> @@ -364,8 +364,10 @@ int amdgpu_discovery_reg_base_init(struct 
>> amdgpu_device *adev)
>>                               hw_id_names[le16_to_cpu(ip->hw_id)]);
>>                       adev->reg_offset[hw_ip][ip->number_instance] =
>>                           ip->base_address;
>> -                    adev->ip_versions[hw_ip] =
>> -                        amdgpu_discovery_convert_version(ip->major, 
>> ip->minor, ip->revision);
>> +                    adev->ip_versions[hw_ip + ip->number_instance] =
>> +                        amdgpu_discovery_convert_version(ip->major,
>> +                                         ip->minor,
>> +                                         ip->revision);
> 
> There could be multiple instances with the same hardware id, right? For 
> ex: SDMA in ARCT/ALDE. They don't have discovery table now, regardless 
> does this hold good in such cases?
> 
> Thanks,
> Lijo
> 

Never mind, found that HWIP used here is different from HW_ID.

Thanks,
Lijo

>>                   }
>>               }
>>

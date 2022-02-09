Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E272C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 19:30:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 964EA10E509;
	Wed,  9 Feb 2022 19:30:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B02810E509
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 19:30:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2MMtXKkDoORTmRHIouy17lr0S4EeYwjh2GiKAO1ES5sDjEB3vXNz1JGLlhbuI3Pn/ymgoLOvnqXdgkP+pP5HUvLhZZIu86MsT5gtoLmXJOmhPTc91cWF/kk1TCf8BV8j9rOn1Q/n2R328i0h9OxFLBYu8ynk+3SK46cS87o8nFsqKp9zTRym8NQABHAA2yHS3Ttwt7ja8uILpKQjeEE2qWXcj9OhSznvQz82JwnQ764NzoIltzbx1kd3J/H1UTF4CuiRl3kIW7IrTGMPbhH8iVS5oHyKkTVYn3He+gX3+6Kx4rP46hVZLeJe6AB65a5PeSNn4XVeMjcG5Qh2g/4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ze2nH06ylhorXOwRe7Vaq5n9q+lW+SYsAMZftWoGE/I=;
 b=U4bwJp6DRnO80JqI+vYqqEKOQ26orf9VRo7z62oCKtRjULsfWTLQIj93FQ6vuHyiBZ8yYRNjlmEl8+cuaUWetY4zA+1iPVWK/tudxOLg8XgVPUreYjrEXPESawHVeY8dvCi989g57A0ddGNcaCBhDIyE/IDJAlGxQaBB16B0gJ2TMFElIgut56zpzbsUZnmcbh85EcGFGEhQrk5foTiidL4IxpXPAdY8Urg9W3m6jS6aGhIFaVmlc5Uzyok32ery20INOe2BoRmWpUZQV+h8M5SjGCyyk58lbBZmLhmKm4/u5YizIeYEmZaxSd9AY0DD5k+66sTHwvHmy6RKtInHGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ze2nH06ylhorXOwRe7Vaq5n9q+lW+SYsAMZftWoGE/I=;
 b=RdPd+BO10ucMBsyW+UMupBVVMeZlJ/6q4apUD+N3DAXIwoLRhIPp/6UowJHo4YCugpmO9flyHnhGN2uE8FnxMgjB6Rb56VjiveQ3FdtblBWXUQsLBXkGRdJM+HT8uMdjs77xR8xU2aI5fHzGelNLS4BaT2nsyCwFRkYpOqBTUXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MW2PR12MB4666.namprd12.prod.outlook.com (2603:10b6:302:13::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.14; Wed, 9 Feb 2022 19:30:35 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::7587:626e:3703:9db8]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::7587:626e:3703:9db8%6]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 19:30:35 +0000
Message-ID: <a0395f8f-8d9a-45e3-5c65-ad601d6f872c@amd.com>
Date: Wed, 9 Feb 2022 14:30:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/1] drm/amdgpu: Show IP discovery in sysfs
Content-Language: en-CA
From: Luben Tuikov <luben.tuikov@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220209163007.10522-1-luben.tuikov@amd.com>
 <20220209163007.10522-2-luben.tuikov@amd.com>
 <CADnq5_MrSBvDiDS_420tk8XRNJ2ER24XL7Ex704LDufbcv5OMA@mail.gmail.com>
 <432fa920-244c-0d79-b68c-118b0dff5647@amd.com>
In-Reply-To: <432fa920-244c-0d79-b68c-118b0dff5647@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTOPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::44) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 839e243a-3965-47fe-bae1-08d9ec02a528
X-MS-TrafficTypeDiagnostic: MW2PR12MB4666:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB46663487405F3C31B5C75380992E9@MW2PR12MB4666.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9qa/SFQN5jlfPkxm5jmrjKM2AAh073TUdo3+raAiEjOu/TW7YyZM3zbvNY54thcbi3oScstTTuJHpAkjtPWnCqgq0c/EmqT8Xrvi7fDlvv10oekD0E3boyozuBaaKFYkXHGjeVjfkYVabQ28K8F6we9Cdc8N89zDfX3bD+zwJSrUwVi+rRj3mjX6ImCMJXKcvi2bwi4+71p8QS7ZBAXy7C7ukDPF4KxMTi3vxLOSgFLwWieL7B93e7hYQmrYwRa1bjA2LoXfK1Cndal+f02pHQwqFLbaD1jmBlf/D+f54ISF1AEG4Wz6CbSZ/0NmJ+kUrZirafMXhH8Nzj+UEmwiEIqRrfW/EunH2G+ho5T4hS0Fj/udkcfiirrwc2eYXKfY6EAbF23IY6TUbIqBt38hAPrC+jlz0fcCYQ1Q3FOeTCPYOpETnxFcvILci3UkDFQvZBy6LB3SUwaN7y/AxH0QAHAH+ggnHu1GxVBHEJ6P9eVOQG5XaR65+dcq2Ku/M8hBZFPkYMwDZU8cF7mRE0bQAuASlJr/EWjNqz//0Emel4aDEcDMaTQy+yXUqT++0wiRJpDWrWQ0xO+q9GRumYcP66bw8cucd/Oua8tvXhsKVBeE27HZmIMsNQuBXcmgB7aIwp8RNO7hWfFygMsPyUQWTZsGhU8///fIOsCC7816WDjTMa2rYDswdpAPs80MJmrmnDv00XCJSZt7uAOFs9sMq5rkV+9/smlkVmPZbIKsemg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(4326008)(6512007)(53546011)(6506007)(5660300002)(6486002)(44832011)(8676002)(31686004)(6916009)(54906003)(6666004)(2616005)(316002)(38100700002)(30864003)(186003)(26005)(508600001)(8936002)(31696002)(86362001)(66556008)(66946007)(66476007)(83380400001)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDY1Tk4rZmNDNHlwbUVNYXNuZUpMaU5NZ0VJNWJQUFdPWW9xMkhjYWFscmF2?=
 =?utf-8?B?TGdENFVIbUJRQkhtZkRmTnYzbk9YaFU0VENQR1VpWkRRak5meXNZZUN4Kzl6?=
 =?utf-8?B?akxDWklXVUZoM1h2R0NxaEhaSThudGNlL2kzMWFWSy9VY1Vxa1ZNeW1UVFBU?=
 =?utf-8?B?VUh0UTAwVG1EL2owamx4Y1N3ZW1IN2UwSUZ1V3A3NnpOKzFSemdKZzZzUFhy?=
 =?utf-8?B?ZGxWbitMWnh5MHpaU094azNra2FXdUUvQWdjV05YSW5BYStoK0RudG4vRzBl?=
 =?utf-8?B?U2ZXaWtBUW4yYTh5OTJmVEtsZk1aOVdMbExxMm03UWZsaWFvUnRmRTVZaVpl?=
 =?utf-8?B?UmpOeG5RRkRRdG5mMGFBR1dGZ1FCQ3hCZFY5RXlaTTJCRjhucmtBU1pXS2Rl?=
 =?utf-8?B?OXNUbnpGaHJPa0ZWRmlOeDZoVEdjMXlhZGViREoyUjBDWVVEOFhEbEhid05i?=
 =?utf-8?B?NE1ka09qTFFwK2RNdEc0RVpUcVQ5SER6MEJuc0psbHBJaGFJbEhzclJBMG9V?=
 =?utf-8?B?UXhNYXdHVGZBUHJHc3h2S1lqUmxpZ0R2NVFRdVZ0ZmR2TGxlcC8xWXhZUE54?=
 =?utf-8?B?eU1kZ3VpTWM1QlE4R0VlcmV2dzg5SEpqRTk4SEhNQnNsZ1RZOEM5enNXNzhQ?=
 =?utf-8?B?Vk1KeHRHd011UVdUa1ZUV24xK3NSOWMyWWh2VFN5WFRpUUhNeXNUekNyTUVO?=
 =?utf-8?B?U0tqN1JSY2dDZDVzUUh3QXNVS09WVVZwZU9tOGt3b24wcFViY3dqbUpEaysw?=
 =?utf-8?B?K3dRVnM3M2N5ajVVeVhWZW9hZU1kUklBcGF0eGpjaEhMbUxMUER3c1NPZzlI?=
 =?utf-8?B?Vk5vcGNyU1NMMW9PZ21TUTUzRFQxNG4vVmlOelFIdW11N1VUN1dWaUYxekpq?=
 =?utf-8?B?R1hNSDRkNkp6ekNmUmtCVnVDek9hK0JwNXlYOUU2R0V0Y3JPaFZ6NzlPZjNm?=
 =?utf-8?B?MndiNWs1dVBqUURoWGozc1Z1UHdkMEtzWmdzWjhOdmRsTnNjVDlNY2ZtVzRv?=
 =?utf-8?B?RUVWWWI0Y1pHcTI2NWVqWkN3VEdLVlByWGVKVC9YbHB0SHVidEN1aUhRaXds?=
 =?utf-8?B?czdrUUI3TkhBYjNCa0ZGL1ZGWWMyNkxNVmdtM3UzU05ITWhaOTJJT2ZyNWxQ?=
 =?utf-8?B?cDJEMm11OEtCcmpkeDdzTWZCelVvNGxTekNxbmVwMGVTdXJPaWQ3bE9kakJx?=
 =?utf-8?B?bHl4RnBRWm5hYzN5QmdnVWdGdnpRUzZMMEhaN0MzSzhrWHc5UHd3N1BsRXNl?=
 =?utf-8?B?SnM5SWhlM3FNSDkvdzhLNG9GUERDdURkS3Z3dzRBcklzVS9wbHkvMlhXSGNh?=
 =?utf-8?B?SlNYTjNqbXB1NlZxWnV5VHN1TXJwRTVRSGY2YkEwN3JZTjZzaFczU0J6L0Uv?=
 =?utf-8?B?MkgzS2NvbUR2bGl0TkpjRndRSzVYZlU4RHBWNStJNmVoWmxxMDFWQ1MwSUpQ?=
 =?utf-8?B?N29EMFNOalJDcEQvdG1iUTdQUm9HdDE2b1UwRnhnejRwTEtPUldBcnEyMlJM?=
 =?utf-8?B?ek1kTlhJZUxYb0hCL244dENpYkxHN2xFN3RIbG1FSG1DYldwdGxwVzNNU01V?=
 =?utf-8?B?SDVIN2JzeGhUWFFhdmJyMm04Vkg5MWg5eG1SRjRoVUhxcXk2ZEJ6Y21tRXNG?=
 =?utf-8?B?MkZkVWV5SG5EbnVDMmlaNzk2bzlGL2wvV2hCNFBubVM2NXoyeEdrTFpGMHFJ?=
 =?utf-8?B?OG00S3VqSHZES0ZXWXdSSlBmSFUxczREb1ZLMkRFYnFNK1FFZ3ExS2p2NUJZ?=
 =?utf-8?B?K0d6YmhTKzdQLzBvRnE5M1hpNUxMbXhGUHI0dFlWMW5hcGJkRlpKRyt0QWdr?=
 =?utf-8?B?eVVteU9ZTnNrNmd4V3dWMkVjZUJHZWtZeEFaakVSZmU5Y2xuOWlvRzFnenVT?=
 =?utf-8?B?aHdFY2ZmcEtCYkkwTWJoKzA2SWhJcmIvRlBCSytOM1dSd3Jqb0tlaFVibmFE?=
 =?utf-8?B?NE9EOEdNLzJXMk8yRWNlUmJMU3pDRkdMQ09kaS9aT3NRNllaM29PWVkwL3lN?=
 =?utf-8?B?RWNuZEpibWk3eENCL2tPb2hpbWNNR2JLTS8xazE0RDZpOTkwMW9hR3BMZVpH?=
 =?utf-8?B?RmZEc0FxSWtHcUlkM2IyMXovT0FXL0VmbmZ0QlBka2psamlkeXZTNzBuRWpq?=
 =?utf-8?Q?0t/E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839e243a-3965-47fe-bae1-08d9ec02a528
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 19:30:35.6041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llYcXbRbu3v27xH/KF540MjVeZRrxq/5GxfKgjZDbzmDJFB9mZ9BrvfN8qpV/nIV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4666
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Tom StDenis <tom.stdenis@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-02-09 14:21, Luben Tuikov wrote:
> 
> 
> On 2022-02-09 13:54, Alex Deucher wrote:
>> On Wed, Feb 9, 2022 at 11:30 AM Luben Tuikov <luben.tuikov@amd.com> wrote:
>>>
>>> Add IP discovery data in sysfs. The format is:
>>> /sys/class/drm/cardX/device/ip_discovery/die/D/B/I/<attrs>
>>> where,
>>> X is the card ID, an integer,
>>> D is the die ID, an integer,
>>> B is the IP HW ID, an integer, aka block type,
>>> I is the IP HW ID instance, an integer.
>>> <attrs> are the attributes of the block instance. At the moment these
>>> include HW ID, instance number, major, minor, revision, number of base
>>> addresses, and the base addresses themselves.
>>>
>>> A symbolic link of the acronym HW ID is also created, under D/, if you
>>> prefer to browse by something humanly accessible.
>>>
>>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>>> Cc: Tom StDenis <tom.stdenis@amd.com>
>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   4 +
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 423 +++++++++++++++++-
>>>  2 files changed, 426 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index e4eb812ade2fa4..3a126dce8a2fe9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -772,6 +772,8 @@ struct amd_powerplay {
>>>         const struct amd_pm_funcs *pp_funcs;
>>>  };
>>>
>>> +struct ip_discovery_top;
>>> +
>>>  /* polaris10 kickers */
>>>  #define ASICID_IS_P20(did, rid)                (((did == 0x67DF) && \
>>>                                          ((rid == 0xE3) || \
>>> @@ -1097,6 +1099,8 @@ struct amdgpu_device {
>>>         bool                            ram_is_direct_mapped;
>>>
>>>         struct list_head                ras_list;
>>> +
>>> +       struct ip_discovery_top         *ip_top;
>>>  };
>>>
>>>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> index 07623634fdc2f1..427400ccc90662 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> @@ -382,6 +382,425 @@ static int amdgpu_discovery_validate_ip(const struct ip *ip)
>>>         return 0;
>>>  }
>>>
>>> +/* ================================================== */
>>> +
>>> +struct ip_hw_instance {
>>> +       struct kobject kobj; /* ip_discovery/die/#die/#hw_id/#instance/<attrs...> */
>>> +
>>> +       int hw_id;
>>> +       u8  num_instance;
>>> +       u8  major, minor, revision;
>>> +
>>> +       int num_base_addresses;
>>> +       u32 base_addr[0];
>>> +};
>>> +
>>> +struct ip_hw_id {
>>> +       struct kset hw_id_kset;  /* ip_discovery/die/#die/#hw_id/ */
>>> +       int hw_id;
>>> +};
>>> +
>>> +struct ip_die_entry {
>>> +       struct kset ip_kset;     /* ip_discovery/die/#die/  */
>>> +       u16 num_ips;
>>> +};
>>> +
>>> +/* -------------------------------------------------- */
>>> +
>>> +struct ip_hw_instance_attr {
>>> +       struct attribute attr;
>>> +       ssize_t (*show)(struct ip_hw_instance *ip_hw_instance, char *buf);
>>> +};
>>> +
>>> +static ssize_t hw_id_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>>> +{
>>> +       return sprintf(buf, "%d\n", ip_hw_instance->hw_id);
>>> +}
>>> +
>>> +static ssize_t num_instance_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>>> +{
>>> +       return sprintf(buf, "%d\n", ip_hw_instance->num_instance);
>>> +}
>>> +
>>> +static ssize_t major_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>>> +{
>>> +       return sprintf(buf, "%d\n", ip_hw_instance->major);
>>> +}
>>> +
>>> +static ssize_t minor_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>>> +{
>>> +       return sprintf(buf, "%d\n", ip_hw_instance->minor);
>>> +}
>>> +
>>> +static ssize_t revision_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>>> +{
>>> +       return sprintf(buf, "%d\n", ip_hw_instance->revision);
>>> +}
>>> +
>>> +static ssize_t num_base_addresses_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>>> +{
>>> +       return sprintf(buf, "%d\n", ip_hw_instance->num_base_addresses);
>>> +}
>>> +
>>> +static ssize_t base_addr_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>>> +{
>>> +       ssize_t res = 0;
>>> +       int ii;
>>> +
>>> +       for (ii = 0; ii < ip_hw_instance->num_base_addresses; ii++) {
>>> +               if (res + 12 >= PAGE_SIZE)
>>> +                       break;
>>> +               res += sprintf(buf + res, "0x%08X\n", ip_hw_instance->base_addr[ii]);
>>> +       }
>>> +
>>> +       return res;
>>> +}
>>> +
>>> +static struct ip_hw_instance_attr ip_hw_attr[] = {
>>> +       __ATTR_RO(hw_id),
>>> +       __ATTR_RO(num_instance),
>>> +       __ATTR_RO(major),
>>> +       __ATTR_RO(minor),
>>> +       __ATTR_RO(revision),
>>> +       __ATTR_RO(num_base_addresses),
>>> +       __ATTR_RO(base_addr),
>>> +};
>>> +
>>> +static struct attribute *ip_hw_instance_attrs[] = {
>>> +       &ip_hw_attr[0].attr,
>>> +       &ip_hw_attr[1].attr,
>>> +       &ip_hw_attr[2].attr,
>>> +       &ip_hw_attr[3].attr,
>>> +       &ip_hw_attr[4].attr,
>>> +       &ip_hw_attr[5].attr,
>>> +       &ip_hw_attr[6].attr,
>>> +       NULL,
>>> +};
>>> +ATTRIBUTE_GROUPS(ip_hw_instance);
>>> +
>>> +#define to_ip_hw_instance(x) container_of(x, struct ip_hw_instance, kobj)
>>> +#define to_ip_hw_instance_attr(x) container_of(x, struct ip_hw_instance_attr, attr)
>>> +
>>> +static ssize_t ip_hw_instance_attr_show(struct kobject *kobj,
>>> +                                       struct attribute *attr,
>>> +                                       char *buf)
>>> +{
>>> +       struct ip_hw_instance *ip_hw_instance = to_ip_hw_instance(kobj);
>>> +       struct ip_hw_instance_attr *ip_hw_attr = to_ip_hw_instance_attr(attr);
>>> +
>>> +       if (!ip_hw_attr->show)
>>> +               return -EIO;
>>> +
>>> +       return ip_hw_attr->show(ip_hw_instance, buf);
>>> +}
>>> +
>>> +static const struct sysfs_ops ip_hw_instance_sysfs_ops = {
>>> +       .show = ip_hw_instance_attr_show,
>>> +};
>>> +
>>> +static void ip_hw_instance_release(struct kobject *kobj)
>>> +{
>>> +       struct ip_hw_instance *ip_hw_instance = to_ip_hw_instance(kobj);
>>> +
>>> +       kfree(ip_hw_instance);
>>> +}
>>> +
>>> +static struct kobj_type ip_hw_instance_ktype = {
>>> +       .release = ip_hw_instance_release,
>>> +       .sysfs_ops = &ip_hw_instance_sysfs_ops,
>>> +       .default_groups = ip_hw_instance_groups,
>>> +};
>>> +
>>> +/* -------------------------------------------------- */
>>> +
>>> +#define to_ip_hw_id(x)  container_of(to_kset(x), struct ip_hw_id, hw_id_kset)
>>> +
>>> +static void ip_hw_id_release(struct kobject *kobj)
>>> +{
>>> +       struct ip_hw_id *ip_hw_id = to_ip_hw_id(kobj);
>>> +
>>> +       /* TODO: Check that the kset is empty. */
>>> +       kfree(ip_hw_id);
>>> +}
>>> +
>>> +static struct kobj_type ip_hw_id_ktype = {
>>> +       .release = ip_hw_id_release,
>>> +       .sysfs_ops = &kobj_sysfs_ops,
>>> +};
>>> +
>>> +/* -------------------------------------------------- */
>>> +
>>> +static void die_kobj_release(struct kobject *kobj);
>>> +static void ip_disc_release(struct kobject *kobj);
>>> +
>>> +struct ip_die_entry_attribute {
>>> +       struct attribute attr;
>>> +       ssize_t (*show)(struct ip_die_entry *ip_die_entry, char *buf);
>>> +};
>>> +
>>> +#define to_ip_die_entry_attr(x)  container_of(x, struct ip_die_entry_attribute, attr)
>>> +
>>> +static ssize_t num_ips_show(struct ip_die_entry *ip_die_entry, char *buf)
>>> +{
>>> +       return sprintf(buf, "%d\n", ip_die_entry->num_ips);
>>> +}
>>> +
>>> +/* If there are more ip_die_entry attrs, other than the number of IPs,
>>> + * we can make this intro an array of attrs, and then initialize
>>> + * ip_die_entry_attrs in a loop.
>>> + */
>>> +static struct ip_die_entry_attribute num_ips_attr =
>>> +       __ATTR_RO(num_ips);
>>> +
>>> +static struct attribute *ip_die_entry_attrs[] = {
>>> +       &num_ips_attr.attr,
>>> +       NULL,
>>> +};
>>> +ATTRIBUTE_GROUPS(ip_die_entry); /* ip_die_entry_groups */
>>> +
>>> +#define to_ip_die_entry(x) container_of(to_kset(x), struct ip_die_entry, ip_kset)
>>> +
>>> +static ssize_t ip_die_entry_attr_show(struct kobject *kobj,
>>> +                                     struct attribute *attr,
>>> +                                     char *buf)
>>> +{
>>> +       struct ip_die_entry_attribute *ip_die_entry_attr = to_ip_die_entry_attr(attr);
>>> +       struct ip_die_entry *ip_die_entry = to_ip_die_entry(kobj);
>>> +
>>> +       if (!ip_die_entry_attr->show)
>>> +               return -EIO;
>>> +
>>> +       return ip_die_entry_attr->show(ip_die_entry, buf);
>>> +}
>>> +
>>> +static void ip_die_entry_release(struct kobject *kobj)
>>> +{
>>> +       struct ip_die_entry *ip_die_entry = to_ip_die_entry(kobj);
>>> +
>>> +       /* TODO: Check that the kset is empty. */
>>> +       kfree(ip_die_entry);
>>> +}
>>> +
>>> +static const struct sysfs_ops ip_die_entry_sysfs_ops = {
>>> +       .show = ip_die_entry_attr_show,
>>> +};
>>> +
>>> +static struct kobj_type ip_die_entry_ktype = {
>>> +       .release = ip_die_entry_release,
>>> +       .sysfs_ops = &ip_die_entry_sysfs_ops,
>>> +       .default_groups = ip_die_entry_groups,
>>> +};
>>> +
>>> +static struct kobj_type die_kobj_ktype = {
>>> +       .release = die_kobj_release,
>>> +       .sysfs_ops = &kobj_sysfs_ops,
>>> +};
>>> +
>>> +static struct kobj_type ip_discovery_ktype = {
>>> +       .release = ip_disc_release,
>>> +       .sysfs_ops = &kobj_sysfs_ops,
>>> +};
>>> +
>>> +struct ip_discovery_top {
>>> +       struct kobject kobj;    /* ip_discovery/ */
>>> +       struct kset die_kset;   /* ip_discovery/die/ */
>>> +       struct amdgpu_device *adev;
>>> +};
>>> +
>>> +static void die_kobj_release(struct kobject *kobj)
>>> +{
>>> +       ;
>>> +}
>>> +
>>> +static void ip_disc_release(struct kobject *kobj)
>>> +{
>>> +       struct ip_discovery_top *ip_top = container_of(kobj, struct ip_discovery_top,
>>> +                                                      kobj);
>>> +       struct amdgpu_device *adev = ip_top->adev;
>>> +
>>> +       /* TODO: Check that the kset is empty. */
>>> +       adev->ip_top = NULL;
>>> +       kfree(ip_top);
>>> +}
>>> +
>>> +static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
>>> +                                     struct ip_die_entry *ip_die_entry,
>>> +                                     const size_t _ip_offset, const int num_ips)
>>> +{
>>> +       int ii, jj, kk, res;
>>> +
>>> +       DRM_DEBUG("num_ips:%d", num_ips);
>>> +
>>> +       /* Find all IPs of a given HW ID, and add their instance to
>>> +        * #die/#hw_id/#instance/<attributes>
>>> +        */
>>> +       for (ii = 0; ii < HW_ID_MAX; ii++) {
>>> +               struct ip_hw_id *ip_hw_id = NULL;
>>> +               size_t ip_offset = _ip_offset;
>>> +
>>> +               for (jj = 0; jj < num_ips; jj++) {
>>> +                       struct ip *ip;
>>> +                       struct ip_hw_instance *ip_hw_instance;
>>> +
>>> +                       ip = (struct ip *)(adev->mman.discovery_bin + ip_offset);
>>> +                       if (amdgpu_discovery_validate_ip(ip) ||
>>> +                           le16_to_cpu(ip->hw_id) != ii)
>>> +                               goto next_ip;
>>> +
>>> +                       DRM_DEBUG("match:%d @ ip_offset:%ld", ii, ip_offset);
>>> +
>>> +                       /* We have a hw_id match; register the hw
>>> +                        * block if not yet registered.
>>> +                        */
>>> +                       if (!ip_hw_id) {
>>> +                               ip_hw_id = kzalloc(sizeof(*ip_hw_id), GFP_KERNEL);
>>> +                               if (!ip_hw_id)
>>> +                                       return -ENOMEM;
>>> +                               ip_hw_id->hw_id = ii;
>>> +
>>> +                               kobject_set_name(&ip_hw_id->hw_id_kset.kobj, "%d", ii);
>>> +                               ip_hw_id->hw_id_kset.kobj.kset = &ip_die_entry->ip_kset;
>>> +                               ip_hw_id->hw_id_kset.kobj.ktype = &ip_hw_id_ktype;
>>> +                               res = kset_register(&ip_hw_id->hw_id_kset);
>>> +                               if (res) {
>>> +                                       DRM_ERROR("Couldn't register ip_hw_id kset");
>>> +                                       kfree(ip_hw_id);
>>> +                                       return res;
>>> +                               }
>>> +                               if (hw_id_names[ii]) {
>>> +                                       res = sysfs_create_link(&ip_die_entry->ip_kset.kobj,
>>> +                                                               &ip_hw_id->hw_id_kset.kobj,
>>> +                                                               hw_id_names[ii]);
>>> +                                       if (res) {
>>> +                                               DRM_ERROR("Couldn't create IP link %s in IP Die:%s\n",
>>> +                                                         hw_id_names[ii],
>>> +                                                         kobject_name(&ip_die_entry->ip_kset.kobj));
>>> +                                       }
>>> +                               }
>>> +                       }
>>> +
>>> +                       /* Now register its instance.
>>> +                        */
>>> +                       ip_hw_instance = kzalloc(sizeof(*ip_hw_instance) +
>>> +                                                sizeof(u32) * ip->num_base_address,
>>> +                                                GFP_KERNEL);
>>> +                       if (!ip_hw_instance) {
>>> +                               DRM_ERROR("no memory for ip_hw_instance");
>>> +                               return -ENOMEM;
>>> +                       }
>>> +                       ip_hw_instance->hw_id = le16_to_cpu(ip->hw_id); /* == ii */
>>
>> Not sure we need the hw_id since that is already part of the directory
>> structure.
> 
> It's part of the attribute set, so I left it there for completeness.
> 
>>
>>> +                       ip_hw_instance->num_instance = ip->number_instance;
>>> +                       ip_hw_instance->major = ip->major;
>>> +                       ip_hw_instance->minor = ip->minor;
>>> +                       ip_hw_instance->revision = ip->revision;
>>
>> Bikeshed, but maybe just combine these into a version leaf instead.  I
>> don't know that we need to keep them separate.
> 
> I don't want to interpret this for user space and users. If you insist,
> then please let me know the format of the format string.

The other point is that these are attributes and presented verbatim in sysfs.

Someone only familiar with the binary data layout, would be surprised to see
this interpreted and randomly formatted, rather then the attributes shown vebatim.

Moreover, we lose their nomenclature if we scrub them and reinterpret them.

I say, we just provide the attributes and leave it to user space to pick and choose
what they are interested in.

For instance, a user might be interested ONLY in the major version, and so they
have a way of finding components with such and such major version, as opposed to
having to DECOMPOSE a formatted "version"--something which the kernel composed which
had been stored in separate attributes already.

I say we leave this interpretation to userspace.

Regards,
Luben

> 
>>
>>> +                       ip_hw_instance->num_base_addresses = ip->num_base_address;
>>> +
>>> +                       for (kk = 0; kk < ip_hw_instance->num_base_addresses; kk++)
>>> +                               ip_hw_instance->base_addr[kk] = ip->base_address[kk];
>>> +
>>> +                       kobject_init(&ip_hw_instance->kobj, &ip_hw_instance_ktype);
>>> +                       ip_hw_instance->kobj.kset = &ip_hw_id->hw_id_kset;
>>> +                       res = kobject_add(&ip_hw_instance->kobj, NULL,
>>> +                                         "%d", ip_hw_instance->num_instance);
>>> +next_ip:
>>> +                       ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
>>> +               }
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
>>> +{
>>> +       struct binary_header *bhdr;
>>> +       struct ip_discovery_header *ihdr;
>>> +       struct die_header *dhdr;
>>> +       struct kset *die_kset = &adev->ip_top->die_kset;
>>> +       u16 num_dies, die_offset, num_ips;
>>> +       size_t ip_offset;
>>> +       int ii, res;
>>> +
>>> +       bhdr = (struct binary_header *)adev->mman.discovery_bin;
>>> +       ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin +
>>> +                                             le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
>>> +       num_dies = le16_to_cpu(ihdr->num_dies);
>>> +
>>> +       DRM_DEBUG("number of dies: %d\n", num_dies);
>>> +
>>> +       for (ii = 0; ii < num_dies; ii++) {
>>> +               struct ip_die_entry *ip_die_entry;
>>> +
>>> +               die_offset = le16_to_cpu(ihdr->die_info[ii].die_offset);
>>> +               dhdr = (struct die_header *)(adev->mman.discovery_bin + die_offset);
>>> +               num_ips = le16_to_cpu(dhdr->num_ips);
>>> +               ip_offset = die_offset + sizeof(*dhdr);
>>> +
>>> +               /* Add the die to the kset.
>>> +                *
>>> +                * dhdr->die_id == ii, which was checked in
>>> +                * amdgpu_discovery_reg_base_init().
>>> +                */
>>> +
>>> +               ip_die_entry = kzalloc(sizeof(*ip_die_entry), GFP_KERNEL);
>>> +               if (!ip_die_entry)
>>> +                       return -ENOMEM;
>>> +
>>> +               ip_die_entry->num_ips = num_ips;
>>> +
>>> +               kobject_set_name(&ip_die_entry->ip_kset.kobj, "%d", le16_to_cpu(dhdr->die_id));
>>> +               ip_die_entry->ip_kset.kobj.kset = die_kset;
>>> +               ip_die_entry->ip_kset.kobj.ktype = &ip_die_entry_ktype;
>>> +               res = kset_register(&ip_die_entry->ip_kset);
>>> +               if (res) {
>>> +                       DRM_ERROR("Couldn't register ip_die_entry kset");
>>> +                       kfree(ip_die_entry);
>>> +                       return res;
>>> +               }
>>> +
>>> +               amdgpu_discovery_sysfs_ips(adev, ip_die_entry, ip_offset, num_ips);
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int amdgpu_discovery_sysfs(struct amdgpu_device *adev)
>>> +{
>>> +       struct kset *die_kset;
>>> +       int res;
>>> +
>>> +       adev->ip_top = kzalloc(sizeof(*adev->ip_top), GFP_KERNEL);
>>> +       if (!adev->ip_top)
>>> +               return -ENOMEM;
>>> +
>>> +       adev->ip_top->adev = adev;
>>> +
>>> +       res = kobject_init_and_add(&adev->ip_top->kobj, &ip_discovery_ktype,
>>> +                                  &adev->dev->kobj, "ip_discovery");
>>> +       if (res) {
>>> +               DRM_ERROR("Couldn't init and add ip_discovery/");
>>> +               goto Err;
>>> +       }
>>> +
>>> +       die_kset = &adev->ip_top->die_kset;
>>> +       kobject_set_name(&die_kset->kobj, "%s", "die");
>>> +       die_kset->kobj.parent = &adev->ip_top->kobj;
>>> +       die_kset->kobj.ktype = &die_kobj_ktype;
>>> +       res = kset_register(&adev->ip_top->die_kset);
>>> +       if (res) {
>>> +               DRM_ERROR("Couldn't register die_kset");
>>> +               goto Err;
>>> +       }
>>> +
>>> +       res = amdgpu_discovery_sysfs_recurse(adev);
>>> +
>>> +       return res;
>>> +Err:
>>> +       kobject_put(&adev->ip_top->kobj);
>>> +       return res;
>>> +}
>>> +
>>> +/* ================================================== */
>>> +
>>>  int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>>>  {
>>>         struct binary_header *bhdr;
>>> @@ -405,7 +824,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>>>
>>>         bhdr = (struct binary_header *)adev->mman.discovery_bin;
>>>         ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin +
>>> -                       le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
>>> +                                             le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
>>>         num_dies = le16_to_cpu(ihdr->num_dies);
>>>
>>>         DRM_DEBUG("number of dies: %d\n", num_dies);
>>> @@ -492,6 +911,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>>>                 }
>>>         }
>>>
>>> +       amdgpu_discovery_sysfs(adev);
>>> +
>>
>> We should probably also tear this down in amdgpu_discovery_fini() or
>> is that already handled some other way via sysfs?
> 
> No, it is not. I'll add this as well. This is why I left comment crumbs.
> 
> Regards,
> Luben
> 
>>
>> Alex
>>
>>>         return 0;
>>>  }
>>>
>>> --
>>> 2.35.0.3.gb23dac905b
>>>
> 
> Regards,

Regards,
-- 
Luben

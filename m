Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7534AC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 19:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED76E10E4E9;
	Wed,  9 Feb 2022 19:21:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6706310E57E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 19:21:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OusAlhdMcS2o7nwc94vgX1MZvKqy1qYsccs2mlS4BMdNN37kLh2TjHBjLD7G3WWqv2w5BiDL5GqJwTc1Wb1c1YQLO19Vvg/YG5p4dvwKUdQgxFXBeRU5cCBVVaTjN2//GqlL11SC342qVKaqYEkL8xZ9tA96/B3ZV3RRwEzWT/ZJxbBAGtOpo7uay9CG2Zfxb7sTmlLkafPy39eT17Sf/nI2Vl0zjVkvmrpQ8B6J0t1+fooo7KGCHBQ0NCtw4JYwyOdOe42KAp4G1j8eUBnbQZuHdgwjRYc9orptfP7h6gWT15KHMznUrDaGdS3hoQ8fN4kp9qaPbCFpXVdLHc2VyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcc/KgsolaaZTFv0TjFFdX8CiamT7jnSXLJAfkDD40E=;
 b=meN1tmvyk/5gR8rFIdxIt+Jyl6pFwlCLowtR42T0HaiYxszBnfFrpgnFVkV9SZ0hdiOxKfI4TdTQrERIOBDJGB0tygKxXXY3ZYgnuRdWNT3tbwxshwK+A/rzkN/aRuOco0SsM8dJkg17JyW1CP4td44UGIoePel4WyYtcwnujaeCu04D17BiOvMGD6gn1ON+UfkoXMcQ5IVut1RCMyjxA+piFdWCClpyNtkd3yIeDduNUN1FqYVcrq5g4jsQ10p/wEXKPraeL8npx+h8K10gkLajCTuZT031JQM1elrtARr5K4aoRjL84u1orPj94augTlDEQGPf7QfoHaK9paZlNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcc/KgsolaaZTFv0TjFFdX8CiamT7jnSXLJAfkDD40E=;
 b=PLfQbzzLv2VEts3GhFrVDTRmIYNEqqcCB8uzahYhNYuJAAFXZaZZd2AT1lmbZ4iST4j2oOqrSSWUuenZiTZIV/IxDxIxwxhc53u1zKv3lxh1Tij/2DL+lACT02bUnQg3iSo58e2eCbzzfXT2OE/yTJncpsvtVgQwrQbDXVINjgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 BN6PR12MB1283.namprd12.prod.outlook.com (2603:10b6:404:19::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11; Wed, 9 Feb 2022 19:21:38 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::7587:626e:3703:9db8]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::7587:626e:3703:9db8%6]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 19:21:38 +0000
Message-ID: <432fa920-244c-0d79-b68c-118b0dff5647@amd.com>
Date: Wed, 9 Feb 2022 14:21:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/1] drm/amdgpu: Show IP discovery in sysfs
Content-Language: en-CA
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220209163007.10522-1-luben.tuikov@amd.com>
 <20220209163007.10522-2-luben.tuikov@amd.com>
 <CADnq5_MrSBvDiDS_420tk8XRNJ2ER24XL7Ex704LDufbcv5OMA@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <CADnq5_MrSBvDiDS_420tk8XRNJ2ER24XL7Ex704LDufbcv5OMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::22) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19680b7e-05f1-45b3-5030-08d9ec0164b2
X-MS-TrafficTypeDiagnostic: BN6PR12MB1283:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1283CA4537B0F03034D3F04B992E9@BN6PR12MB1283.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mXNmkZDde2h6/hZenMvUZ0VX9kNEn5HtoQRnAWHvGF167Az68aW/54IYPtQSiiRdwh9SZ8rPIyMtqbVjHf64QK9UsYNpxJJvn2uYDue3QL6Vex0VhD6DZUVdN56ouwQjMZ9slx4/a9DkvysP2lYTZXw95KrJNE7mP9A7ssSu53wX6igrxBdfTScurwbOl4BC7VK0bpIJSbIdPp0P0nyAjS4ZQcDJTyal37unyc0KDmCcvR78px+f5dqquUjCK+HW9qAWtqQovjPfXpmq8NJrBQ4ZGXia0NEiVC6WQ/k/qggIY8KkERkBqhMKto/juQ9vIeXi+70z4lmgQaIdgTkopgT4DL5jCA+jyc58NvcKBpdWJj0C23O2lpbbKeDKYTLe5LFa7Z5K7VpYNBuezJbqWQDVKOP9VqExT0xpVX4/F6az2ako/CGOUutRcIe2ej60ZtMWJYo+JoOBo7eskjU1DqvElG13COjbXxGyEjIMRyTJqE8LXfD24u82xW0t4KJvzHOreypHsNfHyA4FXISLLNKtZ4HbCSIEweVkxQ0gtyYrCEao2MBCoPpwhrEZnkUE35Otzei4pF/xNk9zvDG0EDSAOYMO1xUj8qHl3BONUd2K2xrWZZNoMMQ2kbL4LRJ6iK6DyJOKX5dMNMjPUFAza7V+lb6/jjuh1U++Fv7AdkRCH4Oa0Vda1kXd5CfzEIkLM5hWmskgfx7KMsO0eWYe4Cw8On83WLyfge5N9n52plA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(44832011)(5660300002)(2906002)(31686004)(31696002)(30864003)(38100700002)(36756003)(316002)(66556008)(54906003)(66476007)(508600001)(66946007)(6916009)(2616005)(26005)(186003)(8936002)(8676002)(86362001)(6486002)(6512007)(83380400001)(6506007)(4326008)(53546011)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1BOdkNzd04xTlhvbjU1VzcxSkxiZzhDbzREeUF3b2NpVFc2blptMHlBMko5?=
 =?utf-8?B?ZExkS2JNWWlUOUpaS2ZmQjh2cGZKa1FPalM4bXVGemFjQ1BwUyt5Ritud0to?=
 =?utf-8?B?dzd2V0JlRDlyQldubzlwVUg5aW1iOHlSdnRHTXl6R0NDc2xpMDQxSko4MHdr?=
 =?utf-8?B?RWxIaEZaWG9LN0FxYXRUcXJ0clRhTDY3RjdGZE15MTlOTCtyM0R6aHJTUXhz?=
 =?utf-8?B?UlhQOFdHU2lsMmpZL000R0Z0dThuSjZ2Y0N6UmJaTlVjOEVpZ0hJbmFhODd6?=
 =?utf-8?B?c3hua3FkSzNUVGtVUnBWVWxPTnZtelNUU2lHVFNMRzN6OUVsZTN4T0dpRTBH?=
 =?utf-8?B?K2VrNnBuUzEvR2FqTGVSUHdxUFNRYUZyMW9XdEw3THhkVnVXa2l1N28xUXpO?=
 =?utf-8?B?MnpqVkptNkljbzhDaWIvU0kyYTdybjJuc0dIYm5HckdLclVJc1RvUDNTR1V3?=
 =?utf-8?B?VVMyQmtOOHNrT0o4SnVQNkFzQUZsendUN0JtQnlzajFLdGhqakxrb29tK25M?=
 =?utf-8?B?Y1B2bVplS2RiRWV2VGU4aTZ4Yng3cVM3TUs1cDZuNE9NaVlrc25JdkV4b1M0?=
 =?utf-8?B?bnBzQmp6ZlZEODJlMEJCbXlnQk9RVVBxa3VIVHUzWHI0VC9wd2RvT3JqeTkr?=
 =?utf-8?B?QjhCbHFZTjYwS0JlZ1VNZU15UWJWUGZqOGtqR2JMeEp1M2lCUktUS0tsN0lD?=
 =?utf-8?B?WUxOcW1TcUovKzZiMjNJYUoxNzA1UkNqR3M0dHk2T2JDemhXNFU0YjhqUWZr?=
 =?utf-8?B?RlQ1S1dIK2tWOTNSVnJTcEZCaCtVQjQ3ZDJRSm16RExGbE5jM0pPQVltUjR5?=
 =?utf-8?B?MGVnNkJVMFpjWjNMK0RpL1RkMmZKREN1bU9IT1hWY0dUbjU3MHNGMjNSMFBU?=
 =?utf-8?B?TEpodGF5eS95Y3crNkJuMFhnQ2tBL2I4cWlNdG54VEFadXBnVnBPWEx0cldu?=
 =?utf-8?B?ZzN3SUdHbHZHSEpoblhYdC9QY1h4VDZubkxSU2x1ZG1jZFUwbnIyUU9wSHJ2?=
 =?utf-8?B?QWJEZ3RnSnM2QWVxMUtjaEZBZTJUMVhwczZ4aWJ4NFB2cDdaek5rM3MrWUs2?=
 =?utf-8?B?YWZNU2xqODBWNWNRMldSRm5FMklsa2MvM2gybU1ZaHpBS1hkSEFGa0paaGQz?=
 =?utf-8?B?MUVLUldmSE9zVGF6eUxKOUNnZko2Y2c0VlJyQzI2OER0RVVHZVJKT29uK1ZZ?=
 =?utf-8?B?dExjeFc4UVNRRWNtczRJMTJRcXFidEZ5ZlFXT1JmU0ROa2puSDExZk9hZEVh?=
 =?utf-8?B?L21QME9uUHlQT2FldE1lazdhUXJDeHdGRktiOTdKYlNBNTBwbXhKVER2eVdr?=
 =?utf-8?B?UlEvQUsxcHVSRVJZS2lMcTVzcjJlVG5ZVERhZ1FDQkRMS0U4RC9TN1B6RzB4?=
 =?utf-8?B?NjFSUUdmTks2Szl3TDhEd3YzWng2blR1eWZtQ1Jnc0o3aFdBeE83ZW1Idzll?=
 =?utf-8?B?NGsvc3p2b0xrWjVLa1oyTTdVemhnUGRwN1RZZ216VjdocWxPR091T3cxMEpv?=
 =?utf-8?B?UGZxTUZjNi9FYmZIQm9JR0MxNjBLTU51S1pmeXRKNlZ1cnU1eVhTSGduUTR3?=
 =?utf-8?B?WmpEaDF1dnUzSWc1VUZmbTd3U3htcjRndURNaFQ1WXJwZWc3aXdkSzZzbCtO?=
 =?utf-8?B?anNmbTJGS01FODU5NytvOGxnVVpsTkJ5VEcxZXk2cU5ZTmhoZTdoanQxVS9m?=
 =?utf-8?B?cUY2WXdpdm1aVGliNG5LblE4b2lFSFZ1dFV4TXd1L0JNalJpTyt4SmRQN0VS?=
 =?utf-8?B?TFA2bkxtQWZSOFNKSGRBNmlseDduMStKQWxZOXk4Ui9xdWFqVWw1ZkxJZWx3?=
 =?utf-8?B?NXVMUk9sbjFNNTdvc3lXWnBPdHFqUmUzYkJiZEpKYzhQNU1RaWFpQXExTExK?=
 =?utf-8?B?aHJrYWkxN0RBRFJjOUdZZ2o5RDNRVm4zdS9VMExxaXNGUk1YdWVCdXAvMDUz?=
 =?utf-8?B?YUFVNUQ0YnlzaXdnbUlNVm03UWZXT0dCeGdsdlM3bEpwOHAyamd3MHcvRjBG?=
 =?utf-8?B?elBYYW9LdUZVYy9tckFwK3BINGZ1MHhTSC9YNlNyd0dNeTh1MzhtdUR0L1dE?=
 =?utf-8?B?c2JTTWZZT0ZIdVAxejZERGpBZFlWbE5ieGd6amRDM25Xd1NiVDR4ZU1VcFky?=
 =?utf-8?Q?IOrM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19680b7e-05f1-45b3-5030-08d9ec0164b2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 19:21:38.0196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJyMdAttaeFx8WVCF4joM0XltqFSa8MIMGwzYPscl0StRsokfhPhztkBzvJlUNyG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1283
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



On 2022-02-09 13:54, Alex Deucher wrote:
> On Wed, Feb 9, 2022 at 11:30 AM Luben Tuikov <luben.tuikov@amd.com> wrote:
>>
>> Add IP discovery data in sysfs. The format is:
>> /sys/class/drm/cardX/device/ip_discovery/die/D/B/I/<attrs>
>> where,
>> X is the card ID, an integer,
>> D is the die ID, an integer,
>> B is the IP HW ID, an integer, aka block type,
>> I is the IP HW ID instance, an integer.
>> <attrs> are the attributes of the block instance. At the moment these
>> include HW ID, instance number, major, minor, revision, number of base
>> addresses, and the base addresses themselves.
>>
>> A symbolic link of the acronym HW ID is also created, under D/, if you
>> prefer to browse by something humanly accessible.
>>
>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>> Cc: Tom StDenis <tom.stdenis@amd.com>
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   4 +
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 423 +++++++++++++++++-
>>  2 files changed, 426 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index e4eb812ade2fa4..3a126dce8a2fe9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -772,6 +772,8 @@ struct amd_powerplay {
>>         const struct amd_pm_funcs *pp_funcs;
>>  };
>>
>> +struct ip_discovery_top;
>> +
>>  /* polaris10 kickers */
>>  #define ASICID_IS_P20(did, rid)                (((did == 0x67DF) && \
>>                                          ((rid == 0xE3) || \
>> @@ -1097,6 +1099,8 @@ struct amdgpu_device {
>>         bool                            ram_is_direct_mapped;
>>
>>         struct list_head                ras_list;
>> +
>> +       struct ip_discovery_top         *ip_top;
>>  };
>>
>>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> index 07623634fdc2f1..427400ccc90662 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> @@ -382,6 +382,425 @@ static int amdgpu_discovery_validate_ip(const struct ip *ip)
>>         return 0;
>>  }
>>
>> +/* ================================================== */
>> +
>> +struct ip_hw_instance {
>> +       struct kobject kobj; /* ip_discovery/die/#die/#hw_id/#instance/<attrs...> */
>> +
>> +       int hw_id;
>> +       u8  num_instance;
>> +       u8  major, minor, revision;
>> +
>> +       int num_base_addresses;
>> +       u32 base_addr[0];
>> +};
>> +
>> +struct ip_hw_id {
>> +       struct kset hw_id_kset;  /* ip_discovery/die/#die/#hw_id/ */
>> +       int hw_id;
>> +};
>> +
>> +struct ip_die_entry {
>> +       struct kset ip_kset;     /* ip_discovery/die/#die/  */
>> +       u16 num_ips;
>> +};
>> +
>> +/* -------------------------------------------------- */
>> +
>> +struct ip_hw_instance_attr {
>> +       struct attribute attr;
>> +       ssize_t (*show)(struct ip_hw_instance *ip_hw_instance, char *buf);
>> +};
>> +
>> +static ssize_t hw_id_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>> +{
>> +       return sprintf(buf, "%d\n", ip_hw_instance->hw_id);
>> +}
>> +
>> +static ssize_t num_instance_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>> +{
>> +       return sprintf(buf, "%d\n", ip_hw_instance->num_instance);
>> +}
>> +
>> +static ssize_t major_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>> +{
>> +       return sprintf(buf, "%d\n", ip_hw_instance->major);
>> +}
>> +
>> +static ssize_t minor_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>> +{
>> +       return sprintf(buf, "%d\n", ip_hw_instance->minor);
>> +}
>> +
>> +static ssize_t revision_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>> +{
>> +       return sprintf(buf, "%d\n", ip_hw_instance->revision);
>> +}
>> +
>> +static ssize_t num_base_addresses_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>> +{
>> +       return sprintf(buf, "%d\n", ip_hw_instance->num_base_addresses);
>> +}
>> +
>> +static ssize_t base_addr_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>> +{
>> +       ssize_t res = 0;
>> +       int ii;
>> +
>> +       for (ii = 0; ii < ip_hw_instance->num_base_addresses; ii++) {
>> +               if (res + 12 >= PAGE_SIZE)
>> +                       break;
>> +               res += sprintf(buf + res, "0x%08X\n", ip_hw_instance->base_addr[ii]);
>> +       }
>> +
>> +       return res;
>> +}
>> +
>> +static struct ip_hw_instance_attr ip_hw_attr[] = {
>> +       __ATTR_RO(hw_id),
>> +       __ATTR_RO(num_instance),
>> +       __ATTR_RO(major),
>> +       __ATTR_RO(minor),
>> +       __ATTR_RO(revision),
>> +       __ATTR_RO(num_base_addresses),
>> +       __ATTR_RO(base_addr),
>> +};
>> +
>> +static struct attribute *ip_hw_instance_attrs[] = {
>> +       &ip_hw_attr[0].attr,
>> +       &ip_hw_attr[1].attr,
>> +       &ip_hw_attr[2].attr,
>> +       &ip_hw_attr[3].attr,
>> +       &ip_hw_attr[4].attr,
>> +       &ip_hw_attr[5].attr,
>> +       &ip_hw_attr[6].attr,
>> +       NULL,
>> +};
>> +ATTRIBUTE_GROUPS(ip_hw_instance);
>> +
>> +#define to_ip_hw_instance(x) container_of(x, struct ip_hw_instance, kobj)
>> +#define to_ip_hw_instance_attr(x) container_of(x, struct ip_hw_instance_attr, attr)
>> +
>> +static ssize_t ip_hw_instance_attr_show(struct kobject *kobj,
>> +                                       struct attribute *attr,
>> +                                       char *buf)
>> +{
>> +       struct ip_hw_instance *ip_hw_instance = to_ip_hw_instance(kobj);
>> +       struct ip_hw_instance_attr *ip_hw_attr = to_ip_hw_instance_attr(attr);
>> +
>> +       if (!ip_hw_attr->show)
>> +               return -EIO;
>> +
>> +       return ip_hw_attr->show(ip_hw_instance, buf);
>> +}
>> +
>> +static const struct sysfs_ops ip_hw_instance_sysfs_ops = {
>> +       .show = ip_hw_instance_attr_show,
>> +};
>> +
>> +static void ip_hw_instance_release(struct kobject *kobj)
>> +{
>> +       struct ip_hw_instance *ip_hw_instance = to_ip_hw_instance(kobj);
>> +
>> +       kfree(ip_hw_instance);
>> +}
>> +
>> +static struct kobj_type ip_hw_instance_ktype = {
>> +       .release = ip_hw_instance_release,
>> +       .sysfs_ops = &ip_hw_instance_sysfs_ops,
>> +       .default_groups = ip_hw_instance_groups,
>> +};
>> +
>> +/* -------------------------------------------------- */
>> +
>> +#define to_ip_hw_id(x)  container_of(to_kset(x), struct ip_hw_id, hw_id_kset)
>> +
>> +static void ip_hw_id_release(struct kobject *kobj)
>> +{
>> +       struct ip_hw_id *ip_hw_id = to_ip_hw_id(kobj);
>> +
>> +       /* TODO: Check that the kset is empty. */
>> +       kfree(ip_hw_id);
>> +}
>> +
>> +static struct kobj_type ip_hw_id_ktype = {
>> +       .release = ip_hw_id_release,
>> +       .sysfs_ops = &kobj_sysfs_ops,
>> +};
>> +
>> +/* -------------------------------------------------- */
>> +
>> +static void die_kobj_release(struct kobject *kobj);
>> +static void ip_disc_release(struct kobject *kobj);
>> +
>> +struct ip_die_entry_attribute {
>> +       struct attribute attr;
>> +       ssize_t (*show)(struct ip_die_entry *ip_die_entry, char *buf);
>> +};
>> +
>> +#define to_ip_die_entry_attr(x)  container_of(x, struct ip_die_entry_attribute, attr)
>> +
>> +static ssize_t num_ips_show(struct ip_die_entry *ip_die_entry, char *buf)
>> +{
>> +       return sprintf(buf, "%d\n", ip_die_entry->num_ips);
>> +}
>> +
>> +/* If there are more ip_die_entry attrs, other than the number of IPs,
>> + * we can make this intro an array of attrs, and then initialize
>> + * ip_die_entry_attrs in a loop.
>> + */
>> +static struct ip_die_entry_attribute num_ips_attr =
>> +       __ATTR_RO(num_ips);
>> +
>> +static struct attribute *ip_die_entry_attrs[] = {
>> +       &num_ips_attr.attr,
>> +       NULL,
>> +};
>> +ATTRIBUTE_GROUPS(ip_die_entry); /* ip_die_entry_groups */
>> +
>> +#define to_ip_die_entry(x) container_of(to_kset(x), struct ip_die_entry, ip_kset)
>> +
>> +static ssize_t ip_die_entry_attr_show(struct kobject *kobj,
>> +                                     struct attribute *attr,
>> +                                     char *buf)
>> +{
>> +       struct ip_die_entry_attribute *ip_die_entry_attr = to_ip_die_entry_attr(attr);
>> +       struct ip_die_entry *ip_die_entry = to_ip_die_entry(kobj);
>> +
>> +       if (!ip_die_entry_attr->show)
>> +               return -EIO;
>> +
>> +       return ip_die_entry_attr->show(ip_die_entry, buf);
>> +}
>> +
>> +static void ip_die_entry_release(struct kobject *kobj)
>> +{
>> +       struct ip_die_entry *ip_die_entry = to_ip_die_entry(kobj);
>> +
>> +       /* TODO: Check that the kset is empty. */
>> +       kfree(ip_die_entry);
>> +}
>> +
>> +static const struct sysfs_ops ip_die_entry_sysfs_ops = {
>> +       .show = ip_die_entry_attr_show,
>> +};
>> +
>> +static struct kobj_type ip_die_entry_ktype = {
>> +       .release = ip_die_entry_release,
>> +       .sysfs_ops = &ip_die_entry_sysfs_ops,
>> +       .default_groups = ip_die_entry_groups,
>> +};
>> +
>> +static struct kobj_type die_kobj_ktype = {
>> +       .release = die_kobj_release,
>> +       .sysfs_ops = &kobj_sysfs_ops,
>> +};
>> +
>> +static struct kobj_type ip_discovery_ktype = {
>> +       .release = ip_disc_release,
>> +       .sysfs_ops = &kobj_sysfs_ops,
>> +};
>> +
>> +struct ip_discovery_top {
>> +       struct kobject kobj;    /* ip_discovery/ */
>> +       struct kset die_kset;   /* ip_discovery/die/ */
>> +       struct amdgpu_device *adev;
>> +};
>> +
>> +static void die_kobj_release(struct kobject *kobj)
>> +{
>> +       ;
>> +}
>> +
>> +static void ip_disc_release(struct kobject *kobj)
>> +{
>> +       struct ip_discovery_top *ip_top = container_of(kobj, struct ip_discovery_top,
>> +                                                      kobj);
>> +       struct amdgpu_device *adev = ip_top->adev;
>> +
>> +       /* TODO: Check that the kset is empty. */
>> +       adev->ip_top = NULL;
>> +       kfree(ip_top);
>> +}
>> +
>> +static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
>> +                                     struct ip_die_entry *ip_die_entry,
>> +                                     const size_t _ip_offset, const int num_ips)
>> +{
>> +       int ii, jj, kk, res;
>> +
>> +       DRM_DEBUG("num_ips:%d", num_ips);
>> +
>> +       /* Find all IPs of a given HW ID, and add their instance to
>> +        * #die/#hw_id/#instance/<attributes>
>> +        */
>> +       for (ii = 0; ii < HW_ID_MAX; ii++) {
>> +               struct ip_hw_id *ip_hw_id = NULL;
>> +               size_t ip_offset = _ip_offset;
>> +
>> +               for (jj = 0; jj < num_ips; jj++) {
>> +                       struct ip *ip;
>> +                       struct ip_hw_instance *ip_hw_instance;
>> +
>> +                       ip = (struct ip *)(adev->mman.discovery_bin + ip_offset);
>> +                       if (amdgpu_discovery_validate_ip(ip) ||
>> +                           le16_to_cpu(ip->hw_id) != ii)
>> +                               goto next_ip;
>> +
>> +                       DRM_DEBUG("match:%d @ ip_offset:%ld", ii, ip_offset);
>> +
>> +                       /* We have a hw_id match; register the hw
>> +                        * block if not yet registered.
>> +                        */
>> +                       if (!ip_hw_id) {
>> +                               ip_hw_id = kzalloc(sizeof(*ip_hw_id), GFP_KERNEL);
>> +                               if (!ip_hw_id)
>> +                                       return -ENOMEM;
>> +                               ip_hw_id->hw_id = ii;
>> +
>> +                               kobject_set_name(&ip_hw_id->hw_id_kset.kobj, "%d", ii);
>> +                               ip_hw_id->hw_id_kset.kobj.kset = &ip_die_entry->ip_kset;
>> +                               ip_hw_id->hw_id_kset.kobj.ktype = &ip_hw_id_ktype;
>> +                               res = kset_register(&ip_hw_id->hw_id_kset);
>> +                               if (res) {
>> +                                       DRM_ERROR("Couldn't register ip_hw_id kset");
>> +                                       kfree(ip_hw_id);
>> +                                       return res;
>> +                               }
>> +                               if (hw_id_names[ii]) {
>> +                                       res = sysfs_create_link(&ip_die_entry->ip_kset.kobj,
>> +                                                               &ip_hw_id->hw_id_kset.kobj,
>> +                                                               hw_id_names[ii]);
>> +                                       if (res) {
>> +                                               DRM_ERROR("Couldn't create IP link %s in IP Die:%s\n",
>> +                                                         hw_id_names[ii],
>> +                                                         kobject_name(&ip_die_entry->ip_kset.kobj));
>> +                                       }
>> +                               }
>> +                       }
>> +
>> +                       /* Now register its instance.
>> +                        */
>> +                       ip_hw_instance = kzalloc(sizeof(*ip_hw_instance) +
>> +                                                sizeof(u32) * ip->num_base_address,
>> +                                                GFP_KERNEL);
>> +                       if (!ip_hw_instance) {
>> +                               DRM_ERROR("no memory for ip_hw_instance");
>> +                               return -ENOMEM;
>> +                       }
>> +                       ip_hw_instance->hw_id = le16_to_cpu(ip->hw_id); /* == ii */
> 
> Not sure we need the hw_id since that is already part of the directory
> structure.

It's part of the attribute set, so I left it there for completeness.

> 
>> +                       ip_hw_instance->num_instance = ip->number_instance;
>> +                       ip_hw_instance->major = ip->major;
>> +                       ip_hw_instance->minor = ip->minor;
>> +                       ip_hw_instance->revision = ip->revision;
> 
> Bikeshed, but maybe just combine these into a version leaf instead.  I
> don't know that we need to keep them separate.

I don't want to interpret this for user space and users. If you insist,
then please let me know the format of the format string.

> 
>> +                       ip_hw_instance->num_base_addresses = ip->num_base_address;
>> +
>> +                       for (kk = 0; kk < ip_hw_instance->num_base_addresses; kk++)
>> +                               ip_hw_instance->base_addr[kk] = ip->base_address[kk];
>> +
>> +                       kobject_init(&ip_hw_instance->kobj, &ip_hw_instance_ktype);
>> +                       ip_hw_instance->kobj.kset = &ip_hw_id->hw_id_kset;
>> +                       res = kobject_add(&ip_hw_instance->kobj, NULL,
>> +                                         "%d", ip_hw_instance->num_instance);
>> +next_ip:
>> +                       ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
>> +{
>> +       struct binary_header *bhdr;
>> +       struct ip_discovery_header *ihdr;
>> +       struct die_header *dhdr;
>> +       struct kset *die_kset = &adev->ip_top->die_kset;
>> +       u16 num_dies, die_offset, num_ips;
>> +       size_t ip_offset;
>> +       int ii, res;
>> +
>> +       bhdr = (struct binary_header *)adev->mman.discovery_bin;
>> +       ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin +
>> +                                             le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
>> +       num_dies = le16_to_cpu(ihdr->num_dies);
>> +
>> +       DRM_DEBUG("number of dies: %d\n", num_dies);
>> +
>> +       for (ii = 0; ii < num_dies; ii++) {
>> +               struct ip_die_entry *ip_die_entry;
>> +
>> +               die_offset = le16_to_cpu(ihdr->die_info[ii].die_offset);
>> +               dhdr = (struct die_header *)(adev->mman.discovery_bin + die_offset);
>> +               num_ips = le16_to_cpu(dhdr->num_ips);
>> +               ip_offset = die_offset + sizeof(*dhdr);
>> +
>> +               /* Add the die to the kset.
>> +                *
>> +                * dhdr->die_id == ii, which was checked in
>> +                * amdgpu_discovery_reg_base_init().
>> +                */
>> +
>> +               ip_die_entry = kzalloc(sizeof(*ip_die_entry), GFP_KERNEL);
>> +               if (!ip_die_entry)
>> +                       return -ENOMEM;
>> +
>> +               ip_die_entry->num_ips = num_ips;
>> +
>> +               kobject_set_name(&ip_die_entry->ip_kset.kobj, "%d", le16_to_cpu(dhdr->die_id));
>> +               ip_die_entry->ip_kset.kobj.kset = die_kset;
>> +               ip_die_entry->ip_kset.kobj.ktype = &ip_die_entry_ktype;
>> +               res = kset_register(&ip_die_entry->ip_kset);
>> +               if (res) {
>> +                       DRM_ERROR("Couldn't register ip_die_entry kset");
>> +                       kfree(ip_die_entry);
>> +                       return res;
>> +               }
>> +
>> +               amdgpu_discovery_sysfs_ips(adev, ip_die_entry, ip_offset, num_ips);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int amdgpu_discovery_sysfs(struct amdgpu_device *adev)
>> +{
>> +       struct kset *die_kset;
>> +       int res;
>> +
>> +       adev->ip_top = kzalloc(sizeof(*adev->ip_top), GFP_KERNEL);
>> +       if (!adev->ip_top)
>> +               return -ENOMEM;
>> +
>> +       adev->ip_top->adev = adev;
>> +
>> +       res = kobject_init_and_add(&adev->ip_top->kobj, &ip_discovery_ktype,
>> +                                  &adev->dev->kobj, "ip_discovery");
>> +       if (res) {
>> +               DRM_ERROR("Couldn't init and add ip_discovery/");
>> +               goto Err;
>> +       }
>> +
>> +       die_kset = &adev->ip_top->die_kset;
>> +       kobject_set_name(&die_kset->kobj, "%s", "die");
>> +       die_kset->kobj.parent = &adev->ip_top->kobj;
>> +       die_kset->kobj.ktype = &die_kobj_ktype;
>> +       res = kset_register(&adev->ip_top->die_kset);
>> +       if (res) {
>> +               DRM_ERROR("Couldn't register die_kset");
>> +               goto Err;
>> +       }
>> +
>> +       res = amdgpu_discovery_sysfs_recurse(adev);
>> +
>> +       return res;
>> +Err:
>> +       kobject_put(&adev->ip_top->kobj);
>> +       return res;
>> +}
>> +
>> +/* ================================================== */
>> +
>>  int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>>  {
>>         struct binary_header *bhdr;
>> @@ -405,7 +824,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>>
>>         bhdr = (struct binary_header *)adev->mman.discovery_bin;
>>         ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin +
>> -                       le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
>> +                                             le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
>>         num_dies = le16_to_cpu(ihdr->num_dies);
>>
>>         DRM_DEBUG("number of dies: %d\n", num_dies);
>> @@ -492,6 +911,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>>                 }
>>         }
>>
>> +       amdgpu_discovery_sysfs(adev);
>> +
> 
> We should probably also tear this down in amdgpu_discovery_fini() or
> is that already handled some other way via sysfs?

No, it is not. I'll add this as well. This is why I left comment crumbs.

Regards,
Luben

> 
> Alex
> 
>>         return 0;
>>  }
>>
>> --
>> 2.35.0.3.gb23dac905b
>>

Regards,
-- 
Luben

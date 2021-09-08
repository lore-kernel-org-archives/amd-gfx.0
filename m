Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C76BC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 22:17:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACEF560F5B
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 22:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ACEF560F5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47F4A6E314;
	Wed,  8 Sep 2021 22:17:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 452576E314
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 22:17:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KseSoP435C4QFpLulOIcW0o/H/BWQjVSOvfoGWSeRjoQ4IsXbXSQ1vsAx6J7y6GU9shJkXsTc9I1489awsgK+l1uLpEAKvEFu5uxsdD4DN2e3cQiOM7pGGpPCKYQq0NCEWkLZATiSHG8v8TL3UCQYbWB8K6kfxa/gxIzyiMWabxootlYiYESc+TUVk9qAQMHcYZNf+zuAZXzj3oNX5JlUdOHa9f00sr+eEUY5WIvsaySz71XZJ24K1/26tbD/cHVZHgXIZvshcAThnh40ORXi2sLmT2xihrIaZjmSJ6e+alEqj9d9UdGwzVRdIt0jI8qJtB5GTkMY9UesNqrouQyGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=lSigjqPWAe6Iv/lKT3QwgAJiujW+YEx5qecWh85ygCg=;
 b=KfodwyEqIRqtFmwhkl1CfeT2lDENUz00HOicGMIie4dznaVr5nP5iMoX7PB+351+W8NttGcBtqqnA7K3m/Z9MhIIWrQKoe7KCm81b+xdC/ie9tNU1hE9zI2g3LTb5IqSnnHwfgzVSzhWZw1uMBGdltoyXH69KsCTvqkm2Uc5X5sGUH3dZP7HBB8g9jR3OrSROeiDtJoOzmubC0lWmB+g/VocLR0ulhQ2fP4phiwcZ/zArgk1bSFCTvwzIqpNx4PilyUETAPBlF34IIyZ2t452ruEm9TgVKxrVolTOPIPzcztdQR04jpc2bYKP62pl400ftfSTtezi/4tpHCj7kyTbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSigjqPWAe6Iv/lKT3QwgAJiujW+YEx5qecWh85ygCg=;
 b=BmaBVrAPEkVV1VvTaWwzKcEYeOZatRBPVixCHqeEM1Di6s6D/mptC5nAsC8VkzwkWj2G86knkHIG4hr0Tb2i9i01ToK0q56j6A2/uZzSVtYsBIWv907qcF2RNL+YzmP4mIK/TSX19lNcMOWiEO94/+DvdeUUCadLquY8aMMrUxA=
Received: from CH0PR12MB5387.namprd12.prod.outlook.com (2603:10b6:610:d6::17)
 by CH0PR12MB5187.namprd12.prod.outlook.com (2603:10b6:610:ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 22:17:48 +0000
Received: from CH0PR12MB5387.namprd12.prod.outlook.com
 ([fe80::5ba:1c46:d9ff:d07b]) by CH0PR12MB5387.namprd12.prod.outlook.com
 ([fe80::5ba:1c46:d9ff:d07b%4]) with mapi id 15.20.4500.016; Wed, 8 Sep 2021
 22:17:48 +0000
From: "Powell, Darren" <Darren.Powell@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>, Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings
Thread-Topic: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings
Thread-Index: AQHXpJQeCKM6NiXM2kinRGAfIw+94KuZ4VSAgAAMTACAACeZAIAAn397
Date: Wed, 8 Sep 2021 22:17:48 +0000
Message-ID: <CH0PR12MB5387C11CD331985AB96F0DCEF0D49@CH0PR12MB5387.namprd12.prod.outlook.com>
References: <20210908055615.3781901-1-lang.yu@amd.com>
 <e8b39f62-ca0c-d4e0-92a9-52487fa0da81@gmail.com>
 <47ed143e-b9ab-a80e-dac0-cfa1ec39d033@amd.com>
 <DM6PR12MB425086A1FFE0D1609581DFBAFBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <39d2443b-c90e-b5c6-85ee-b44bbfd818d3@amd.com>
 <DM6PR12MB4250831801024A782408C280FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <332d81e6-a518-a155-cdfc-008e0bdb324c@amd.com>
 <5edd4df2-c49c-3b87-90d4-8d8b822641f9@gmail.com>
 <1fa7224f-de58-6864-6cb2-16a7b8968f54@amd.com>
 <4e6c0a19-0476-d8ca-c233-6f143cca511c@gmail.com>
In-Reply-To: <4e6c0a19-0476-d8ca-c233-6f143cca511c@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-08T22:17:47.391Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 2bb1065c-9094-ccaf-723b-5d5bf643aec0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85c8597c-3a17-4d27-0e83-08d973167d9b
x-ms-traffictypediagnostic: CH0PR12MB5187:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5187E24A32A8FE6EF8B0636CF0D49@CH0PR12MB5187.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SG0029yWsZZi77iMwvZbDgzq3R17RvlgbQjSlO278Qupq60TAaisrZgVmg47LMu5gnUbsaBqeAvAJqiozoteiNzW/m9CVUWtsp8fPJbku/pM7lXQfwZ68bq3B+FF6hi9yfRjcxQOrzSTzjO3gQDvHhgRfLxXrbKYZwqMZSImjSWysSEV4+MEYPXGM0fQxvMIRsfLuz3RnH4LzEsGx8Gtq+lK8E+0l3eXrS6UXHuofbuC6c1F5U4uDt3Wdcejk7hm0hfAwEgSs9ZwoZ72vIHxUKXnrGiYmbsGwcyYbzKmFCExsaDuDLQczMyaKHFV9wl5GFRyfD7H4VwPMdq55dIAKs9yRc3/qElQZx1Jjndwo9rhCkEP/fIudTDVJW0mCWwJnmiFHWHFXGnJUk5an/IIys7mAsh6QmUesg5XRkwTbtAdnn91uQRyi1u1smUuTaz+xUyGkHfpLjVApF/IHqQBBJ/EiNbMy0ScKIRQIQAls2H606Sc2I45K9mmoKAAFdWGc0RtiEDXXFqaWvQNoJT/rVYGFU8FMT4YkkJ/e+ZBKORzOH4jTBwsQqGwtAXoEglnxfUlaR/RdoubKhYJl9JYxgU3auXfRFSmeHMjGpJ92+OvVo+jeDjRdUNvZtrc1W+jH9/Sab1ggMf5qXkrbtg17UZwCDjsCB8MSWjDWx6r2ppdf46g5SBrOsqqJpRzhj2tgWqI5tJ3AMMZxOKO4T1itg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5387.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(8676002)(4326008)(86362001)(38070700005)(38100700002)(7696005)(316002)(19627405001)(122000001)(6506007)(71200400001)(91956017)(26005)(66946007)(66446008)(76116006)(66574015)(5660300002)(64756008)(478600001)(55016002)(66556008)(53546011)(33656002)(186003)(9686003)(54906003)(8936002)(66476007)(52536014)(110136005)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1kwijdAzq36b4Rs1r7BxJed1VjfwsSliDZFfkQiIM/0QyRv3sWPq9iGFJw?=
 =?iso-8859-1?Q?LHpDs20OTJQ0S+Zbng4mVoa1eNs+x1lTHQ1u3vOLQiyd5gpRfvEQXVQuV5?=
 =?iso-8859-1?Q?e2m6BoZGfN3PwV+vDmQgMukn8lV73wDZh7O1mbkWJqwY7jgIGjmGWyegBt?=
 =?iso-8859-1?Q?XjTLmIGFFcPFkzUCdZonKP8KuHJC4MlFSmpWesTR5JO0ar93H+KQyAMFD+?=
 =?iso-8859-1?Q?jFx4bwoNFt7owmd1Z0DJDacf+uOapq/087FjZzAFKsWuHalfNlOSkj8lhd?=
 =?iso-8859-1?Q?bEMdJlZqbRG0GARgHBODt8U8ctLP/AMq+Uc0jYU++mmGV9bqWB5gSn9PXy?=
 =?iso-8859-1?Q?frQ0IorllDAbxWkEpr1WdkMNxncqp9f4ibyeTPTvLP+FZbyHjOmuP2ADfi?=
 =?iso-8859-1?Q?zg05/ehUlYbFTuZur025EUMWFWrPTFHHdooGqoKTCPkemG0osmK8qDNG0t?=
 =?iso-8859-1?Q?l+aU9Onx1Q40/MLJ0gAKGOTL3Bo9hHkrxZMs+R+Pe4UvoA24F6xl0QF2j8?=
 =?iso-8859-1?Q?01/edFWmD4glfdLg/uVDLaO/+yUhh+xlWqyDrW30t+/y9YuZgGhQk9dGhY?=
 =?iso-8859-1?Q?e5yOSHO4PrwxZ1/+0158/81Fs33RQB6yN9DP+caWmIw/f8WCWf2ko9aPtI?=
 =?iso-8859-1?Q?eHnw6w+X4WSmS+fAcWYuHBxlM4sWGey35XPQ09gTJlf1alrP26ryQwiFTW?=
 =?iso-8859-1?Q?z+VROX2XHUR8ssUFVn6e3RL/jV9zpyYZBsUr2MRNqpILDblgmOl/mOvTds?=
 =?iso-8859-1?Q?gPv7nS2Z+zT2MNigA0ywIGIchVfM6WSFSgRdCCkem1KXdmCT9jJUgcv/Ni?=
 =?iso-8859-1?Q?wK30Z3dpSRe3a5hZtKYGbg62S7GW9LCc1aoxPJqTOpbEuB2zwqCHf6jxa+?=
 =?iso-8859-1?Q?yE7oP6oyc0Mz0De66JMJlB4vRSY+gKJLyjh90HQrmJWQRIiX42x+3ALmPN?=
 =?iso-8859-1?Q?nDC05qvuOulErLVOycwQcTwS+wMY5JYikApQeZXe4mqRCOV3uwBQOxnbgu?=
 =?iso-8859-1?Q?w9e5BH5Cc/F64S9YL96lOWxR/joaRiZIBmtyss++EmD80CwReC053Oi2QK?=
 =?iso-8859-1?Q?7uRXTdz3ul7c9ervMSxyGKmHGUMseWfU1XDD2HCQx78qmCL/cvljL1R9oy?=
 =?iso-8859-1?Q?p0BplJKJoznzE4FvFFPBs5vzeSrhH6vi9GxxuXPsbv/YashR3R4ZMVaKaR?=
 =?iso-8859-1?Q?VLQ7YlFORY2g8+rprNh5B0nbGlcksuYG6p/fLE7KktI9GgsWAYwWB6Pnxb?=
 =?iso-8859-1?Q?PKtkQ/naXYj8imN2yZ0qeuEqrlEriCoMGsodtNPJ2tJcNvZfHIxGNYbrly?=
 =?iso-8859-1?Q?Yyr/L8gZGeoz0toVUzvwt/q8gKUwMQ+GVje94U31vNitCAWfu0stszkr5j?=
 =?iso-8859-1?Q?hmwdsT91RC?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5387C11CD331985AB96F0DCEF0D49CH0PR12MB5387namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5387.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c8597c-3a17-4d27-0e83-08d973167d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 22:17:48.1064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FlKhX8J/8z68VEnLrA38PMuTUNeSOHX0mxs/5uTlyLyqp8MQKoS1GGMwz86NlbgpydlE1ZXK7O+YmKrNnHnDZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5187
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

--_000_CH0PR12MB5387C11CD331985AB96F0DCEF0D49CH0PR12MB5387namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]



________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Wednesday, September 8, 2021 8:43 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Yu, Lang <Lang.Yu@amd.com>; amd-gfx@l=
ists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Tian Tao <tiantao6@hisilicon.com>; Powell, Darren <Darren.Powell@a=
md.com>
Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings

Am 08.09.21 um 12:22 schrieb Lazar, Lijo:
> On 9/8/2021 3:08 PM, Christian K=F6nig wrote:
>> Am 08.09.21 um 11:29 schrieb Lazar, Lijo:
>>> On 9/8/2021 2:32 PM, Yu, Lang wrote:
>>>> [AMD Official Use Only]
>>>>> -----Original Message-----
>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>> Sent: Wednesday, September 8, 2021 4:55 PM
>>>>> To: Yu, Lang <Lang.Yu@amd.com>; Christian K=F6nig
>>>>> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org
>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>>> <Ray.Huang@amd.com>; Tian Tao <tiantao6@hisilicon.com>
>>>>> Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at
>>>>> warnings
>>>>>
>>>>>
>>>>>
>>>>> On 9/8/2021 1:14 PM, Yu, Lang wrote:
>>>>>> [AMD Official Use Only]
>>>>>>
>>>>>>
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>>> Sent: Wednesday, September 8, 2021 3:36 PM
>>>>>>> To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>; Yu, Lang
>>>>>>> <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>>>>> <Ray.Huang@amd.com>; Tian Tao <tiantao6@hisilicon.com>
>>>>>>> Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at
>>>>>>> warnings
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 9/8/2021 12:07 PM, Christian K=F6nig wrote:
>>>>>>>> Am 08.09.21 um 07:56 schrieb Lang Yu:
>>>>>>>>> sysfs_emit and sysfs_emit_at requrie a page boundary aligned buf
>>>>>>>>> address. Make them happy!
>>>>>>>>>
>>>>>>>>> Warning Log:
>>>>>>>>> [  492.545174] invalid sysfs_emit_at: buf:00000000f19bdfde at:0 [
>>>>>>>>> 492.546416] WARNING: CPU: 7 PID: 1304 at fs/sysfs/file.c:765
>>>>>>>>> sysfs_emit_at+0x4a/0xa0
>>>>>>>>> [  492.654805] Call Trace:
>>>>>>>>> [  492.655353]  ? smu_cmn_get_metrics_table+0x40/0x50 [amdgpu] [
>>>>>>>>> 492.656780]  vangogh_print_clk_levels+0x369/0x410 [amdgpu] [
>>>>>>>>> 492.658245] vangogh_common_print_clk_levels+0x77/0x80 [amdgpu] [
>>>>>>>>> 492.659733]  ? preempt_schedule_common+0x18/0x30 [ 492.660713]
>>>>>>>>> smu_print_ppclk_levels+0x65/0x90 [amdgpu] [ 492.662107]
>>>>>>>>> amdgpu_get_pp_od_clk_voltage+0x13d/0x190 [amdgpu] [ 492.663620]
>>>>>>>>> dev_attr_show+0x1d/0x40
>>>>>>>>
>>>>>>>> Mhm, that at least partially doesn't looks like the right
>>>>>>>> approach to me.
>>>>>>>>
>>>>>>>> Why do we have string printing and sysfs code in the hardware
>>>>>>>> version specific backend in the first place?
>>>>>>>>
>>>>>>>
>>>>>>> This is a callback meant for printing ASIC specific information to
>>>>>>> sysfs node. The buffer passed in sysfs read is passed as it is
>>>>>>> to the callback API.
>>>>>>>
>>>>>>>> That stuff needs to be implemented for each hardware generation
>>>>>>>> and
>>>>>>>> is now cluttered with sysfs buffer offset calculations.
>>>>>>>>
>>>>>>>
>>>>>>> Looks like the warning happened because of this usage.
>>>>>>>
>>>>>>>                   size =3D amdgpu_dpm_print_clock_levels(adev,
>>>>>>> OD_SCLK, buf);
>>>>>>>                   size +=3D amdgpu_dpm_print_clock_levels(adev,
>>>>>>> OD_MCLK,
>>>>>>> buf+size);
>>>>>>>                   size +=3D amdgpu_dpm_print_clock_levels(adev,
>>>>>>> OD_VDDC_CURVE, buf+size);
>>>>>>>                   size +=3D amdgpu_dpm_print_clock_levels(adev,
>>>>>>> OD_VDDGFX_OFFSET, buf+size);
>>>>>>>                   size +=3D amdgpu_dpm_print_clock_levels(adev,
>>>>>>> OD_RANGE,
>>>>>>> buf+size);
>>>>>>>                   size +=3D amdgpu_dpm_print_clock_levels(adev,
>>>>>>> OD_CCLK,
>>>>>>> buf+size);
>>>>>>>
>>>>>>>
>>>>>> [Yu, Lang]
>>>>>> Yes. So it is fine we just fix the caller
>>>>>> amdgpu_get_pp_od_clk_voltage like
>>>>> following:
>>>>>>
>>>>>> static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>>>>>>         struct device_attribute *attr,
>>>>>>         char *buf)
>>>>>> {
>>>>>>     struct drm_device *ddev =3D dev_get_drvdata(dev);
>>>>>>     struct amdgpu_device *adev =3D drm_to_adev(ddev);
>>>>>>     ssize_t size, offset;
>>>>>>     int ret, i;
>>>>>>     char temp_buf[512];
>>>>>>     char clock_type[] =3D {OD_SCLK, OD_MCLK, OD_VDDC_CURVE,
>>>>>>                          OD_VDDGFX_OFFSET, OD_RANGE, OD_CCLK};
>>>>>>
>>>>>>     if (amdgpu_in_reset(adev))
>>>>>>         return -EPERM;
>>>>>>     if (adev->in_suspend && !adev->in_runpm)
>>>>>>         return -EPERM;
>>>>>>
>>>>>>     ret =3D pm_runtime_get_sync(ddev->dev);
>>>>>>     if (ret < 0) {
>>>>>>         pm_runtime_put_autosuspend(ddev->dev);
>>>>>>         return ret;
>>>>>>     }
>>>>>>
>>>>>>     offset =3D 0;
>>>>>>
>>>>>>     if (adev->powerplay.pp_funcs->print_clock_levels) {
>>>>>>         for (i =3D 0; i < ARRAY_SIZE(clock_type); i++) {
>>>>>>             size =3D amdgpu_dpm_print_clock_levels(adev,
>>>>> clock_type[i], buf);
>>>>>>             if (offset + size > PAGE_SIZE)
>>>>>>                 break;
>>>>>>             memcpy(temp_buf + offset, buf, size);
>>>>>>             offset +=3D size;
>>>>>>         }
>>>>>>         memcpy(buf, temp_buf, offset);
>>>>>>         size =3D offset;
>>>>>>     } else {
>>>>>>         size =3D sysfs_emit(buf, "\n");
>>>>>>     }
>>>>>>     pm_runtime_mark_last_busy(ddev->dev);
>>>>>>     pm_runtime_put_autosuspend(ddev->dev);
>>>>>>
>>>>>>     return size;
>>>>>> }
>>>>>>
>>>>> Prefer to avoid any extra stack or heap usage for buffer. Maybe
>>>>> another arg to
>>>>> pass offset along with buf?
>>>>>
>>>> [Yu, Lang]
>>>> Actually, the buf address contains the offset(offset_in_page(buf)) .
>>>
>>> Though it's not a problem based on codeflow, static analysis tools
>>> might complain.
>>>
>>>> Or we just rollback to sprintf/snprintf.
>>>>
>>>
>>> snprintf with (PAGE_SIZE-size) may be simpler. I think Darren took
>>> the effort to convert these, he may have some other ideas.
The changes I made were intended to simply replace snprintf with sysfs_emit=
 as per
linux/Documentation/filesystems/sysfs.rst:246,247
 -  show() should only use sysfs_emit() or sysfs_emit_at() when formatting
    the value to be returned to user space.

I specifically tried not to change the design, but only as I didn't have
background in Power Management.

>>
>> This is not what I meant. See from the design point of view the
>> print_clock_levels() callback is the bad idea to begin with.
>>
>> What we should have instead is a callback which returns the clock as
>> a value which is then printed in the amdgpu_get_pp_od_clk_voltage()
>> function.
>>
>> This avoids passing around the buffer and remaining size everywhere
>> and also guarantees that the sysfs have unified printing over all
>> hardware generations.
>>
>
> The scenario is one node used for multiple parameters - OD_SCLK,
> OD_CCLK, OD_VDDGFX_OFFSET etc.(mostly to avoid cluttering sysfs with
> lots of nodes). On top of it, the parameters supported (for ex: CCLK
> is not valid on dGPUs),  the number of levels supported etc. vary
> across ASICs. There has to be multiple calls or the call needs to
> return multiple values for a single parameter (for ex: up to 4, 8 or
> 16 levels of GFXCLK depending on ASIC).

Well exactly that is questionable design for sysfs.

See the sysfs_emit() and sysfs_emit_at() functions are designed the way
they are because you should have only one value per file, which is then
printed at exactly one location.

Take a look at the documentation for sysfs for more details.

> I don't know the history of the callback, mostly it was considered
> more efficient to print it directly rather than fetch and print.
> Alex/Evan may know the details.

Yeah, somebody with a bit more background in power management needs to
take a closer look at this here. Just keep me looped in.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>> Regards,
>> Christian.
>>


--_000_CH0PR12MB5387C11CD331985AB96F0DCEF0D49CH0PR12MB5387namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Wednesday, September 8, 2021 8:43 AM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Yu, Lang &lt;Lang.Yu@amd=
.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&g=
t;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Huang, Ray=
 &lt;Ray.Huang@amd.com&gt;; Tian Tao &lt;tiantao6@hisilicon.com&gt;; Powell=
, Darren &lt;Darren.Powell@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnin=
gs</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Am 08.09.21 um 12:22 schrieb Lazar, Lijo:<br>
&gt; On 9/8/2021 3:08 PM, Christian K=F6nig wrote:<br>
&gt;&gt; Am 08.09.21 um 11:29 schrieb Lazar, Lijo:<br>
&gt;&gt;&gt; On 9/8/2021 2:32 PM, Yu, Lang wrote:<br>
&gt;&gt;&gt;&gt; [AMD Official Use Only]<br>
&gt;&gt;&gt;&gt;&gt; -----Original Message-----<br>
&gt;&gt;&gt;&gt;&gt; From: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
&gt;&gt;&gt;&gt;&gt; Sent: Wednesday, September 8, 2021 4:55 PM<br>
&gt;&gt;&gt;&gt;&gt; To: Yu, Lang &lt;Lang.Yu@amd.com&gt;; Christian K=F6ni=
g<br>
&gt;&gt;&gt;&gt;&gt; &lt;ckoenig.leichtzumerken@gmail.com&gt;; amd-gfx@list=
s.freedesktop.org<br>
&gt;&gt;&gt;&gt;&gt; Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&g=
t;; Huang, Ray<br>
&gt;&gt;&gt;&gt;&gt; &lt;Ray.Huang@amd.com&gt;; Tian Tao &lt;tiantao6@hisil=
icon.com&gt;<br>
&gt;&gt;&gt;&gt;&gt; Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_=
emit_at <br>
&gt;&gt;&gt;&gt;&gt; warnings<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; On 9/8/2021 1:14 PM, Yu, Lang wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt; [AMD Official Use Only]<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; -----Original Message-----<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; From: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<b=
r>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Sent: Wednesday, September 8, 2021 3:36 PM<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; To: Christian K=F6nig &lt;ckoenig.leichtzumerk=
en@gmail.com&gt;; Yu, Lang<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; &lt;Lang.Yu@amd.com&gt;; amd-gfx@lists.freedes=
ktop.org<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Cc: Deucher, Alexander &lt;Alexander.Deucher@a=
md.com&gt;; Huang, Ray<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; &lt;Ray.Huang@amd.com&gt;; Tian Tao &lt;tianta=
o6@hisilicon.com&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emi=
t/sysfs_emit_at<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; warnings<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 9/8/2021 12:07 PM, Christian K=F6nig wrote:=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Am 08.09.21 um 07:56 schrieb Lang Yu:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; sysfs_emit and sysfs_emit_at requrie a=
 page boundary aligned buf<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; address. Make them happy!<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Warning Log:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [&nbsp; 492.545174] invalid sysfs_emit=
_at: buf:00000000f19bdfde at:0 [<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 492.546416] WARNING: CPU: 7 PID: 1304 =
at fs/sysfs/file.c:765<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; sysfs_emit_at+0x4a/0xa0<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [&nbsp; 492.654805] Call Trace:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [&nbsp; 492.655353]&nbsp; ? smu_cmn_ge=
t_metrics_table+0x40/0x50 [amdgpu] [<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 492.656780]&nbsp; vangogh_print_clk_le=
vels+0x369/0x410 [amdgpu] [<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 492.658245] vangogh_common_print_clk_l=
evels+0x77/0x80 [amdgpu] [<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 492.659733]&nbsp; ? preempt_schedule_c=
ommon+0x18/0x30 [ 492.660713]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; smu_print_ppclk_levels+0x65/0x90 [amdg=
pu] [ 492.662107]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; amdgpu_get_pp_od_clk_voltage+0x13d/0x1=
90 [amdgpu] [ 492.663620]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; dev_attr_show+0x1d/0x40<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Mhm, that at least partially doesn't looks=
 like the right <br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; approach to me.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Why do we have string printing and sysfs c=
ode in the hardware<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; version specific backend in the first plac=
e?<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; This is a callback meant for printing ASIC spe=
cific information to<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; sysfs node. The buffer passed in sysfs read is=
 passed as it is <br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; to the callback API.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; That stuff needs to be implemented for eac=
h hardware generation <br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; and<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; is now cluttered with sysfs buffer offset =
calculations.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Looks like the warning happened because of thi=
s usage.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D amdgpu_dp=
m_print_clock_levels(adev, <br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; OD_SCLK, buf);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D amdgpu_d=
pm_print_clock_levels(adev, <br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; OD_MCLK,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; buf+size);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D amdgpu_d=
pm_print_clock_levels(adev,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; OD_VDDC_CURVE, buf+size);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D amdgpu_d=
pm_print_clock_levels(adev,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; OD_VDDGFX_OFFSET, buf+size);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D amdgpu_d=
pm_print_clock_levels(adev,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; OD_RANGE,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; buf+size);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D amdgpu_d=
pm_print_clock_levels(adev, <br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; OD_CCLK,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; buf+size);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; [Yu, Lang]<br>
&gt;&gt;&gt;&gt;&gt;&gt; Yes. So it is fine we just fix the caller <br>
&gt;&gt;&gt;&gt;&gt;&gt; amdgpu_get_pp_od_clk_voltage like<br>
&gt;&gt;&gt;&gt;&gt; following:<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; static ssize_t amdgpu_get_pp_od_clk_voltage(struct=
 device *dev,<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
device_attribute *attr,<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *b=
uf)<br>
&gt;&gt;&gt;&gt;&gt;&gt; {<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;struct amdgpu_device *adev=
 =3D drm_to_adev(ddev);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;ssize_t size, offset;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;int ret, i;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;char temp_buf[512];<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;char clock_type[] =3D {OD_=
SCLK, OD_MCLK, OD_VDDC_CURVE,<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; OD_VDDGFX_OFFSET, OD_RANGE, OD_CCLK};<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;if (amdgpu_in_reset(adev))=
<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-EPERM;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;if (adev-&gt;in_suspend &a=
mp;&amp; !adev-&gt;in_runpm)<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-EPERM;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;ret =3D pm_runtime_get_syn=
c(ddev-&gt;dev);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runt=
ime_put_autosuspend(ddev-&gt;dev);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;}<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;offset =3D 0;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;if (adev-&gt;powerplay.pp_=
funcs-&gt;print_clock_levels) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =
=3D 0; i &lt; ARRAY_SIZE(clock_type); i++) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; size =3D amdgpu_dpm_print_clock_levels(adev,<br>
&gt;&gt;&gt;&gt;&gt; clock_type[i], buf);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (offset + size &gt; PAGE_SIZE)<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; memcpy(temp_buf + offset, buf, size);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; offset +=3D size;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(=
buf, temp_buf, offset);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =
=3D offset;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;} else {<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =
=3D sysfs_emit(buf, &quot;\n&quot;);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;}<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;pm_runtime_mark_last_busy(=
ddev-&gt;dev);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;pm_runtime_put_autosuspend=
(ddev-&gt;dev);<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;return size;<br>
&gt;&gt;&gt;&gt;&gt;&gt; }<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Prefer to avoid any extra stack or heap usage for buff=
er. Maybe <br>
&gt;&gt;&gt;&gt;&gt; another arg to<br>
&gt;&gt;&gt;&gt;&gt; pass offset along with buf?<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; [Yu, Lang]<br>
&gt;&gt;&gt;&gt; Actually, the buf address contains the offset(offset_in_pa=
ge(buf)) .<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Though it's not a problem based on codeflow, static analysis t=
ools <br>
&gt;&gt;&gt; might complain.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Or we just rollback to sprintf/snprintf.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; snprintf with (PAGE_SIZE-size) may be simpler. I think Darren =
took <br>
&gt;&gt;&gt; the effort to convert these, he may have some other ideas.<br>
The changes I made were intended to simply replace snprintf with sysfs_emit=
 as per&nbsp;</div>
<div class=3D"PlainText">linux/Documentation/filesystems/sysfs.rst:246,247
<div>&nbsp;- &nbsp;show() should only use sysfs_emit() or sysfs_emit_at() w=
hen formatting</div>
&nbsp; &nbsp; the value to be returned to user space.<br>
</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">I specifically tried not to change the design, but=
 only as I didn't have&nbsp;</div>
<div class=3D"PlainText">background in Power Management.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">&gt;&gt;<br>
&gt;&gt; This is not what I meant. See from the design point of view the <b=
r>
&gt;&gt; print_clock_levels() callback is the bad idea to begin with.<br>
&gt;&gt;<br>
&gt;&gt; What we should have instead is a callback which returns the clock =
as <br>
&gt;&gt; a value which is then printed in the amdgpu_get_pp_od_clk_voltage(=
) <br>
&gt;&gt; function.<br>
&gt;&gt;<br>
&gt;&gt; This avoids passing around the buffer and remaining size everywher=
e <br>
&gt;&gt; and also guarantees that the sysfs have unified printing over all =
<br>
&gt;&gt; hardware generations.<br>
&gt;&gt;<br>
&gt;<br>
&gt; The scenario is one node used for multiple parameters - OD_SCLK, <br>
&gt; OD_CCLK, OD_VDDGFX_OFFSET etc.(mostly to avoid cluttering sysfs with <=
br>
&gt; lots of nodes). On top of it, the parameters supported (for ex: CCLK <=
br>
&gt; is not valid on dGPUs),&nbsp; the number of levels supported etc. vary=
 <br>
&gt; across ASICs. There has to be multiple calls or the call needs to <br>
&gt; return multiple values for a single parameter (for ex: up to 4, 8 or <=
br>
&gt; 16 levels of GFXCLK depending on ASIC).<br>
<br>
Well exactly that is questionable design for sysfs.<br>
<br>
See the sysfs_emit() and sysfs_emit_at() functions are designed the way <br=
>
they are because you should have only one value per file, which is then <br=
>
printed at exactly one location.<br>
<br>
Take a look at the documentation for sysfs for more details.<br>
<br>
&gt; I don't know the history of the callback, mostly it was considered <br=
>
&gt; more efficient to print it directly rather than fetch and print. <br>
&gt; Alex/Evan may know the details.<br>
<br>
Yeah, somebody with a bit more background in power management needs to <br>
take a closer look at this here. Just keep me looped in.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Lijo<br>
&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Christian.<br>
&gt;&gt;<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB5387C11CD331985AB96F0DCEF0D49CH0PR12MB5387namp_--

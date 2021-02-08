Return-Path: <SRS0=WKN7=HK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1871C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 11:50:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E1264E49
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 11:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E1264E49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5C436E8B4;
	Mon,  8 Feb 2021 11:50:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A18A6E8B4
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Feb 2021 11:50:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNJTahvKpb0rlVl+RFbw0HTQczfeVzkDszYzWhgy1hFSf6d+ggX9ekptGo3TG2lJv0Z55zrkcbVuRq8J6RgmfeB2YlQQHXCu8PuT7JpJkbBwB1ngfseJ5AApjbRSuztGuKFNDzR9v/3Q6J/kXAuXdf7r76E86ZzcX2zRf2EeOkRpkl8ACd7CBkn9hfyxbMzPL+gPal4+ck38ZBV5QFn9CIX2acRgPEYwIZuznefHQsZBF6nwLG4qF9PtmTNnPEQ5c8fVZLXCFWPo0u3st3QB3+t7TkzxYKOytsgoBWMtc4M7ciEwyQjVKj9OwnkCn30HMHswQJz2T1A6Jl2iyEx7WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxSg683vNbbiIk1/a4WPiKwIcg/XWLCipmyMfP+4Wz4=;
 b=Q5tIOWaDGjFiKLSvBK7cJOhF81VhaBHqGpai7ZctfinH4+nvaZ8KSsCPbaYPCfSwkhk/21yoaDypINWd+BQq7sg7FoClVRuFM1+2kuRaPsQwzzAWFBktgBq26fXlts3IyM8IxOmt22nQwUFc6GFIxXOW57MwBcSbLrEOKwYtLx49WZV8+sjdkbn5VnYtHU4V4EnWuRnnkxVQAiFMqaQDKAL5qH2GGzinylI9UzsIfF3h4T8UNdC29YOiD75DTxn6C/Uy3YVfEFMPWYEtzJcPgZomxkd9Ni+2hyqvUYyf7O0L2tr8o0yXW+TyJ2B4AyYm4DtXABNHkCE5cr1fvAlHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxSg683vNbbiIk1/a4WPiKwIcg/XWLCipmyMfP+4Wz4=;
 b=KJbn6obTiXcUdMaiLCO//FtDprwCDanzamatA19RSGwG20peDpao/BVOCI9NEzUYKB75d+nK91tb4OQ7Eh5/BLRZQjHw/aLIBg9ok1QrWqHzjqZhhp9nWg7wwsRYB7GA0jUOQf2VhTg22W3visrlroHYnq/ck6P+glD6nxi122A=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Mon, 8 Feb
 2021 11:50:42 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132%3]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 11:50:42 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Gu, JiaWei (Will)"
 <JiaWei.Gu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: extend MAX_KIQ_REG_TRY to 1000
Thread-Topic: [PATCH] drm/amdgpu: extend MAX_KIQ_REG_TRY to 1000
Thread-Index: AQHW/d3C1kjyVbSk30GxJpMSnAV+VapN/b4AgAAJGgCAAAETgIAAHWdA
Date: Mon, 8 Feb 2021 11:50:42 +0000
Message-ID: <BY5PR12MB4115E531ED84A867E239C8D68F8F9@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210208054555.23421-1-Jiawei.Gu@amd.com>
 <13337a59-f698-a91b-5662-1673e14a3cd7@gmail.com>
 <DM6PR12MB4170DCA058C4A96998CC8BFBF88F9@DM6PR12MB4170.namprd12.prod.outlook.com>
 <25cdc423-c22e-7b89-7ff8-272afd197e4f@gmail.com>
In-Reply-To: <25cdc423-c22e-7b89-7ff8-272afd197e4f@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=246173e5-386d-4992-8450-7fc0e66f89fe;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-08T11:49:59Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 910609a0-6cd5-4e36-e297-08d8cc27c330
x-ms-traffictypediagnostic: BYAPR12MB2840:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2840596476ACCE2B3230054F8F8F9@BYAPR12MB2840.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vFkbDYq363mCFuGv3JTtGwOTLkh5sROP2qHzGQZ8j4yAX9ObnZPuqRKZ5/SfarmTqapcyQQt9R7lwQeX0EDnyVYX/jSTfU+eAiNPUg62gxC1WRKObd3TZm1dpJEETZPtaNmCddpx0/YacekgYG860yr/rpj8ZiqDR9X+7ZxgLdQwUxwAsVuTpdWA6DHaSQ7A/cxxl5HsyeQPoAL+cz6v/dnClfE9s8t3tRxdtIlzxtzVcBi4kEK7TCE31OQuk3DsfRDwq0AZg14ZfH/MQG+1kWdiMW+QJw6CImLB/QcBX5H3AoDoZxzeh1OZmfAonN1Rozb3bOx5iziUyiUfaLQEzNF+DXjPsugT1FwkFLeEFm4+u2xccKoavMDQUN3D89Oa167WRaBvOJ20D2N8PvAEgXwQc2rRx47Bv1ilBTy8+NZfyOxZaSEi3v7j1YX4PnZwDeRwXlATHwqhI+bRtGD8AXOHS1dAOktUG7Rj8dGBYIhw63YNFX4Fp/nDPnYHbrY0lQAu8LtzahvQytXV3C4sOFpwnEA20l5qm8cv+FJC4Qnz06aAAapgEkDYrVAh7FIQL1cfUxDY8xj+c+GybuPxFTCN+Jy0M4EbBAFbpRu6NFA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(26005)(7696005)(316002)(110136005)(2906002)(186003)(45080400002)(52536014)(5660300002)(478600001)(8936002)(966005)(9686003)(53546011)(6506007)(55016002)(71200400001)(33656002)(76116006)(66946007)(66574015)(86362001)(83380400001)(8676002)(66476007)(66446008)(64756008)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?brKFOcCqqUF0CMGxc4x0siAhN0LY87Xp8pvmT4v0E5QRuAa97oqQCcgXx+?=
 =?iso-8859-1?Q?M0aBjAcf0dFJi+NxTbPD4CpXILHbioK4HqIELWohPDHJ523mee7QeYBsgJ?=
 =?iso-8859-1?Q?ir/Uqy+slrAYEaFgYJszSdFlLN2D6OYzGeY4uUyNFMWTs+Y+DF2TK/IST6?=
 =?iso-8859-1?Q?DMwAGQq9ogOXgJEzyzJA9VVIrtgpfyQFKcXToUwM4vEW9j9ZW0+gpkgEey?=
 =?iso-8859-1?Q?99fyRlPV0dFJVpr9BDrd3kbsXozpXEstbpMAPzk/tBX105cH9Zq8Kyknv6?=
 =?iso-8859-1?Q?/a7vRg4u3PeKoAyAMv9FLHGyPizAJndeY7LRV9cloLxLkZXLrLIa+NTvQT?=
 =?iso-8859-1?Q?4Q2dzAQmjpMXW2CPNi5rRi3GYY5mad6kE9qZXFTnUMiv278EoDv7S80nHr?=
 =?iso-8859-1?Q?7L8PmVni3GPi+M2tqCFPFHpdNAI8QvIV7WtNYBovG98DMXgeZoyJJEMruz?=
 =?iso-8859-1?Q?xyPUER7xAF06UUB4D0U9TMJVm0gG90HjSktIWUqsSa3Uoyy33lYDfo5zuC?=
 =?iso-8859-1?Q?MTvAsR7zMF1+89oKKOp1FIJs9tVkFXBJfniLeUBQoqMQmekVVuM0W2iQcg?=
 =?iso-8859-1?Q?t9iJGReH/oiR6/qZE7CST7CFbpsK9nvWNzAURzG7ReCERWo7KsFalR5BKY?=
 =?iso-8859-1?Q?Swkkzv/ZW1IPMla+uemXEDIyLXjXdzUb9ZLMnJWKWzdSbheMYOM6tUwuhn?=
 =?iso-8859-1?Q?3bqPrLTC1LOAjzSLHUfyvAyMFW6a0lXEootH8wATWu79KHFoZD9WDbwFR3?=
 =?iso-8859-1?Q?2B1drUz5LKDns2FOU3yedxiHH44kqQlbrsa96d/V6ZvEbC4w/kmAiPHKKV?=
 =?iso-8859-1?Q?oZzIm9oDb7dio3pTwYQY/hui3a/zDYd6DdOHoZ8NfAEYD5EZBMKDkXiaET?=
 =?iso-8859-1?Q?aFeeMJfW3VHcwBD8Q7JshlpCJQGNUTsWN0Sphug3PzdrKQV8AYD12BZlu+?=
 =?iso-8859-1?Q?ihQgTacgN/1P5z7oBjJ6hCb4B2Ph0Glbt3eebgdI3nF2UVZVVDDbbXc6zN?=
 =?iso-8859-1?Q?MMfXDSGQqY2LbOrBkpSiqgGrxYqKnzCgjKK7YCjRUytyqYorDTP3ddMTL9?=
 =?iso-8859-1?Q?G2Q4CorWY356y8nmDIb77vYYWBiliy//64rJC4TYs9/E6Ihee8aTLOfEM1?=
 =?iso-8859-1?Q?l+CVXwcZLV70OmWhZ/U19IV+YombL38PO9hPhlU6z0YgnF2CbZeFkBbA2+?=
 =?iso-8859-1?Q?2Etz14PSIUrOb6vrZB/KaEs58TcysinbIQ7KuksCCcs0laBJf7l2wumioK?=
 =?iso-8859-1?Q?/lXjGovNKI1QUp3OmjqUQlI0A5I6fUwaRiEW6Ml3IfkqGmcQtS7RsAdnEQ?=
 =?iso-8859-1?Q?BX64Q5nTWJ3dWGtFOXo783Y/d3oP3Sb1yFK34+zON/SUB2XG/Blc9p2F7T?=
 =?iso-8859-1?Q?jlONzWt6tE?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910609a0-6cd5-4e36-e297-08d8cc27c330
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 11:50:42.1903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CCg3AHJGznT+H0vbYHuUZ0y6Z8pvZ8QkalZud6/MF0CrNbOomFyUk8B8og0xcofl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2840
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Emily.Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
>Sent: Monday, February 8, 2021 6:05 PM
>To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: Re: [PATCH] drm/amdgpu: extend MAX_KIQ_REG_TRY to 1000
>
>Hi Jiawei,
>
>ok in this case it's fine with me.
>
>Just please also get a reviewed-by from somebody which has more KIQ
>background than I have.
>
>Thanks,
>Christian.
>
>Am 08.02.21 um 11:00 schrieb Gu, JiaWei (Will):
>> [AMD Official Use Only - Internal Distribution Only]
>>
>> Hi Christian,
>>
>> That's how many times it would retry before give up.
>> And we always skip this retry routine if we are in interrupt, so it's fi=
ne for
>interrupt condition.
>>
>> Best regards,
>> Jiawei
>>
>> -----Original Message-----
>> From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
>> Sent: Monday, February 8, 2021 5:28 PM
>> To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>;
>> amd-gfx@lists.freedesktop.org
>> Cc: Deng, Emily <Emily.Deng@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: extend MAX_KIQ_REG_TRY to 1000
>>
>> Am 08.02.21 um 06:45 schrieb Jiawei Gu:
>>> Extend retry times of KIQ to avoid starvation situation caused by
>>> long time full access of GPU by other VFs.
>> In what units is that? We also need the KIQ during interrupt handling and
>that looks like *way* to big for that.
>>
>> Christian.
>>
>>> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 639db32c1383..e0c797a5f739 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -288,7 +288,7 @@ enum amdgpu_kiq_irq {
>>>
>>>    #define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
>>>    #define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
>>> -#define MAX_KIQ_REG_TRY 80 /* 20 -> 80 */
>>> +#define MAX_KIQ_REG_TRY 1000
>>>
>>>    int amdgpu_device_ip_set_clockgating_state(void *dev,
>>>       enum amd_ip_block_type
>block_type,
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist
>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=3D04%7C01%7CEm
>>
>ily.Deng%40amd.com%7Cd3ba1ae698ec408da87f08d8cc18f7b1%7C3dd8961fe
>4884e
>>
>608e11a82d994e183d%7C0%7C0%7C637483754906300007%7CUnknown%7CT
>WFpbGZsb3
>>
>d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
>3D%7
>>
>C1000&amp;sdata=3D%2FLrBdotkzcAepWTBazik9S9ah5ul48DvtCNKN3wYyQU%3
>D&amp;r
>> eserved=3D0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

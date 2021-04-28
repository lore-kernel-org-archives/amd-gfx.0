Return-Path: <SRS0=1eED=JZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F464C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 09:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 946AA61407
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 09:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946AA61407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D5406EAD3;
	Wed, 28 Apr 2021 09:15:23 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680074.outbound.protection.outlook.com [40.107.68.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88BF36EAD6
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 09:15:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOE8aHqFD5Shp8NlX2ittjYTl9VHQawEOCvGBv2aBpNuH+23s73tOEFF3dKuQZ+edsEMLkUxOCliMRv3+kIEWPO4Vu021Y4fSsFKB0fJKowdUBiA10wBnvIe9n8nZerX6WVW/EhdWDYoXWe2zWNN7gOrocdSoCIY6nvOxu+S4rC03ibKiQXS1HoHJqQuf+Byumg6ci583vadqm2XeNUlgdOAnLw70/gqKd2JQ3UF1dmwOY/Zf7ecq86e7LnS38So1+slIM0tKmteD/lvCLT7Y31xZwgdBoPgFKNHi+8egmYiwSEOeOld1NWtT0wRgHdICXIA8E+/5m/X2qaODYVJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcosnZQRU+oj/zqAwdOwDD66YNTjWaLonemcMZkoFzI=;
 b=Ch9wtYud/FRISEbR9bzgx/YBL+7N1lE073ScdKAZhFhBE03eJRXmGqYT1SuYJe8mLQPDBFhNy7f9+AurIaxQFHxPD3y2qx7/YH2M2p9gLOI+KUSTt7B9giOOa8AXaIYGKUQDkuEdpv10HE1mXOSj3xYM/d0T3Jp6i1YQr9wVx/4gM1EqYhri3f2PPzkZugFGmhWimxdbLyvn6lcOfxMzBhh+HxD6mj2+pq/b92UUGdJ/4WfMF1iQheUzDmaFxGpszE+AewCcqlaWWIpKxL0IihgxDY8E38FTWeXie90KRNvUTm3qUhxMy+F2XKyAA5XoWxVwYufXeZEcHXzfcO/FoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcosnZQRU+oj/zqAwdOwDD66YNTjWaLonemcMZkoFzI=;
 b=R74x8W90ldqdGGFua2hn0k9XEAEZnf0nWY0tIu2p175TiGeC70v1hZOdeAJIh3uzTtIRAWnh49coTBD+oW+/y34XK91jcyfoFsQRI9Q767KHcZcP+sKTqOSRvygx4R3yC402qJXKxxnkbAJXrYljezjFVyj5GCiNarbY6U/zRKk=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB4967.namprd12.prod.outlook.com (2603:10b6:a03:1de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 09:15:08 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1c65:648b:7597:388e]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1c65:648b:7597:388e%2]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 09:15:08 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Thread-Topic: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Thread-Index: AQHXOmUtl+qXW/2uo0uk6i4GpDgdCqrGW78AgADS6ACAAASOAIAAAiGAgAABC4CAAmZiAIAACgkAgAACSAA=
Date: Wed, 28 Apr 2021 09:15:08 +0000
Message-ID: <BY5PR12MB4115E1B181665FC0B0DE003B8F409@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210426062701.39732-1-Roy.Sun@amd.com>
 <8b8ec884-5b0b-3409-b7b0-be7da43e3e71@gmail.com>
 <MN2PR12MB4488F5277BF26669E8D8673BF7429@MN2PR12MB4488.namprd12.prod.outlook.com>
 <MN2PR12MB44884F5635594C3F53D3F865F7429@MN2PR12MB4488.namprd12.prod.outlook.com>
 <df0aa92d-87b9-7c27-f06f-9e1a10cead5d@gmail.com>
 <MN2PR12MB44880E0C0FA8C75D7E28884AF7429@MN2PR12MB4488.namprd12.prod.outlook.com>
 <BY5PR12MB41150F5816B764A3E619AB4F8F409@BY5PR12MB4115.namprd12.prod.outlook.com>
 <8529a53a-66ed-60a1-9ae4-279524e5a57f@gmail.com>
In-Reply-To: <8529a53a-66ed-60a1-9ae4-279524e5a57f@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d54874f8-1eac-4fb4-b87a-239e9be8e2fe;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-28T09:14:47Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f95d0ec-b945-4604-dc0c-08d90a261e75
x-ms-traffictypediagnostic: BY5PR12MB4967:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4967D1E4380EB255714E0F298F409@BY5PR12MB4967.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jQWeKfsOPu1ySml4oV9nVe/NqoSQsNpn959xhIXi91Cg1A5osKxDeldtjb7tDwbcM5Q3Wk12GJfreObTPyRDDEe2j+CuHnkpTkxUYNWRq7JUI4s+7a1C6pcmiEPoV/9IdtAadzPUTwlpTfXgieHH0uiu/bAq/taubUfT5iQGXVkw16eeAJRLd6UXRV7vZeJRjePm13RqYek30KqBUNOxJseup7IkBZhPtkZo7D/PkGhVbwpL5IcMNKHBXixregPGGGmhn1bnC+eRmeLbTxnkU5v8Y4InKLBdjUY8VQVheCKh0GhC1IZDVcCBV3GZw+J9CbaxiRBZGnQIsIu3PQn45TB44XdqqioCIHklqoyJieZuZ/WCLH1Y+wkzE2Vq52+kEQIDQqktB+FiMfGi22Gm6/EFPZq40oIO55bp9tMNZCiWdNAexhQnHrWi7jmdBO/3iD3WTpMwgdwmx8AXnZ0TUAnHCL/nCJHvFFDqhB0rgY3aYfw35xLylpWcB298BIOhTjZgzYBSMlX5oAu8xcDYF2CZ3FhF/WfHMdvS4SAheQl6ziejbRBPe69E5LC93TiWtWn4U3VTwMZOesDQBuwvk8VslcpCAvSEmW/iucF59DE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(86362001)(76116006)(8936002)(7696005)(6636002)(83380400001)(2906002)(8676002)(54906003)(33656002)(66476007)(316002)(110136005)(64756008)(66446008)(66946007)(66556008)(4326008)(186003)(6506007)(478600001)(5660300002)(38100700002)(55016002)(122000001)(66574015)(26005)(52536014)(9686003)(71200400001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?pXuWk/PmIpaAZs7IyDlqQyijqVYBtvRQpCzeBaUPlkpykR+LjR/LldbXO/?=
 =?iso-8859-1?Q?gBfY7BYgPLTHSqv7Wdkn7Xe9mOWUcoW8Ov/C88ity/EHlENWZHVGJ6Fhu5?=
 =?iso-8859-1?Q?W4yk4uAMZ+mUNAZS3igQ9GomCTuR0EQDxS1YHPqOHbfLh21I5teCSrUavN?=
 =?iso-8859-1?Q?Vi3cSYpJyIXwNf+77fxtJs3PeAZK3Areq7r6dqSmrpq8PClMSIHbKj1Su3?=
 =?iso-8859-1?Q?1wIhAbrSFFDbUh5cFP0W/ipoCxPhPhnrb6656nI5rgC1LcL6qNE50xzygs?=
 =?iso-8859-1?Q?FfqivLmZptW4RFGNgpCxYYvdjLX+Q7mulOpfCQv9YOKOpBxkfL72hYXWhc?=
 =?iso-8859-1?Q?KA2YXaUp7jhXdqO2WRBUfEUVxnw4GAYgwN1am/SE6dYheBDE34igx/oV10?=
 =?iso-8859-1?Q?t/qfWGAJfUgfbifFGFiEKJMNdgyiMwrzILKIKzGXNODfROc0bt4HPAJj2E?=
 =?iso-8859-1?Q?A5JUbjBWujP+zoh9T5Qz5zbCb2UZSWvi/Z9WW3Qun9pFMpOOuFXTFxiQDd?=
 =?iso-8859-1?Q?qudyJSy39QPxFDXfJi9jfuCnpvnUUAyuKlInN+DmSlE0DlI1tNN9/aPRb7?=
 =?iso-8859-1?Q?s7yt09pJVjrcdiWH5Z9/q5D40lNXlFTsdJX57CtoMaj7Z/XZR7ipyzr1De?=
 =?iso-8859-1?Q?SaQwIA79YVhLN8ktg5hcLXdB5NZ4lNnnn1dtKm9/U9uJMERxa8gji6cvy8?=
 =?iso-8859-1?Q?CCJsBVfi/st3WfZQ42J/3C7PFY1U+EqrHg22lk+FbE5Cst+REFwixpvKMT?=
 =?iso-8859-1?Q?h3tTpdvxVShFFrdtFrjSFqI8zjIvsarW8HcefKlznSmNBCj6XRFGsNTLIa?=
 =?iso-8859-1?Q?u6+rycSj11hc8NW5hRm1O/8Q5twSCkV203kMUnpm+J4VIrgKaqCTndNTsL?=
 =?iso-8859-1?Q?Iii6rV3evvMW0CEz53E2TpOhGN1fXmJpXTsUspmS67PYea7b01lB2wXiUP?=
 =?iso-8859-1?Q?96phTwV9zQ6KCafw11R7cdxecT9uvdsH2gulvm21JmNg+gkuvVGaBEZHtn?=
 =?iso-8859-1?Q?1t2El8nYwOnnNOddsIr/vXgnYO0fWG7SyJf/w0Bqc9ORhqUo0rnVMtAOeN?=
 =?iso-8859-1?Q?A8V8Aj3k/ayfn8eVbpGH37+0skbiCjeacrRzkOEcwRNyvBoxiuPKmxw+ax?=
 =?iso-8859-1?Q?hraC778+MfHKHC1LUrp/khPwH6iig2AOthe4kie1F1O/wmhz8ztKNdsn1N?=
 =?iso-8859-1?Q?WQ8+ONxMUmIDRhcJoBfjMJUASxjjR0AWAlX2jcqBF7n2cUnn+w0i+HieVI?=
 =?iso-8859-1?Q?KYhNZTzBX8/iBe5pwkLMDhrYrqv6itCWQGB6AhL4ujs0q9Sjl2hri3tqgL?=
 =?iso-8859-1?Q?HHMFNvcVXg3+51YlA2mDRJc+rk7nGVhr2p/asWkVB9qMgxpX8P4I9StQWm?=
 =?iso-8859-1?Q?2Ct61Zk454?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f95d0ec-b945-4604-dc0c-08d90a261e75
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 09:15:08.3859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ChCsz9sFJS7cMyLALnIwjeQ2qdMvKwgwTziibZ4xqB4PSf90vXG8fzhlNxcEINK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4967
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Sun, Roy" <Roy.Sun@amd.com>,
 "Nieto, David M" <David.Nieto@amd.com>
Content-Type: multipart/mixed; boundary="===============0036445437=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0036445437==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB4115E1B181665FC0B0DE003B8F409BY5PR12MB4115namp_"

--_000_BY5PR12MB4115E1B181665FC0B0DE003B8F409BY5PR12MB4115namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi Christian,
Good to know, thanks very much.

Best wishes
Emily Deng
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Wednesday, April 28, 2021 5:07 PM
To: Deng, Emily <Emily.Deng@amd.com>; Deucher, Alexander <Alexander.Deucher=
@amd.com>
Cc: Sun, Roy <Roy.Sun@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org=
>; Nieto, David M <David.Nieto@amd.com>
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track

Well none. As I said I will push this upstream through drm-misc-next.

Christian.
Am 28.04.21 um 10:32 schrieb Deng, Emily:

[AMD Official Use Only - Internal Distribution Only]

Hi Alex and Christian,
What extra work Roy need to do about this patch? And fdinfo?

Best wishes
Emily Deng
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> On Behalf Of Deucher, Alexander
Sent: Tuesday, April 27, 2021 3:52 AM
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com><mailto:ckoenig.lei=
chtzumerken@gmail.com>
Cc: Sun, Roy <Roy.Sun@amd.com><mailto:Roy.Sun@amd.com>; amd-gfx list <amd-g=
fx@lists.freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>; Nieto, Dav=
id M <David.Nieto@amd.com><mailto:David.Nieto@amd.com>
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track


[AMD Official Use Only - Internal Distribution Only]


[AMD Official Use Only - Internal Distribution Only]

Fair point.  Either way works for me.

Alex
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.le=
ichtzumerken@gmail.com>>
Sent: Monday, April 26, 2021 3:48 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freede=
sktop.org>>; Sun, Roy <Roy.Sun@amd.com<mailto:Roy.Sun@amd.com>>; Nieto, Dav=
id M <David.Nieto@amd.com<mailto:David.Nieto@amd.com>>
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track

My concern is more to get this tested from more people than just AMD.

Christian.
Am 26.04.21 um 21:40 schrieb Deucher, Alexander:

[AMD Official Use Only - Internal Distribution Only]

That said, it would be easier for me to merge through the AMD tree since a =
relatively big AMD feature depends on it.  Not sure how much conflict poten=
tial there is if this goes through the AMD tree.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Deucher, Alexander <Alexander.Deucher=
@amd.com><mailto:Alexander.Deucher@amd.com>
Sent: Monday, April 26, 2021 3:24 PM
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com><mailto:ckoenig.lei=
chtzumerken@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freed=
esktop.org>; Sun, Roy <Roy.Sun@amd.com><mailto:Roy.Sun@amd.com>; Nieto, Dav=
id M <David.Nieto@amd.com><mailto:David.Nieto@amd.com>
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track


[AMD Official Use Only - Internal Distribution Only]


[AMD Official Use Only - Internal Distribution Only]

No objections from me.

Thanks!

Alex

________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com><mailto:ckoenig.l=
eichtzumerken@gmail.com>
Sent: Monday, April 26, 2021 2:49 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com><mailto:Alexander.Deucher=
@amd.com>
Cc: Nieto, David M <David.Nieto@amd.com><mailto:David.Nieto@amd.com>; Sun, =
Roy <Roy.Sun@amd.com><mailto:Roy.Sun@amd.com>; amd-gfx list <amd-gfx@lists.=
freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track

Hey Alex,

any objections that we merge those two patches through drm-misc-next?

Thanks,
Christian.

Am 26.04.21 um 08:27 schrieb Roy Sun:
> Update the timestamp of scheduled fence on HW
> completion of the previous fences
>
> This allow more accurate tracking of the fence
> execution in HW
>
> Signed-off-by: David M Nieto <david.nieto@amd.com><mailto:david.nieto@amd=
.com>
> Signed-off-by: Roy Sun <Roy.Sun@amd.com><mailto:Roy.Sun@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index 92d8de24d0a1..f8e39ab0c41b 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -515,7 +515,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_scheduler=
 *sched)
>   EXPORT_SYMBOL(drm_sched_resubmit_jobs);
>
>   /**
> - * drm_sched_resubmit_jobs_ext - helper to relunch certain number of job=
s from mirror ring list
> + * drm_sched_resubmit_jobs_ext - helper to relaunch certain number of jo=
bs from pending list
>    *
>    * @sched: scheduler instance
>    * @max: job numbers to relaunch
> @@ -671,7 +671,7 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sch=
ed)
>   static struct drm_sched_job *
>   drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
>   {
> -     struct drm_sched_job *job;
> +     struct drm_sched_job *job, *next;
>
>        /*
>         * Don't destroy jobs while the timeout worker is running  OR thre=
ad
> @@ -690,6 +690,14 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *=
sched)
>        if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
>                /* remove job from pending_list */
>                list_del_init(&job->list);
> We just need to record the scheduled time of the next job. So we
> need not to check the rest job.
> +             /* account for the next fence in the queue */
> +             next =3D list_first_entry_or_null(&sched->pending_list,
> +                             struct drm_sched_job, list);
> +             if (next && test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
> +                     &job->s_fence->finished.flags)) {
> +                     next->s_fence->scheduled.timestamp =3D
> +                             job->s_fence->finished.timestamp;
> +             }
>        } else {
>                job =3D NULL;
>                /* queue timeout for next job */



--_000_BY5PR12MB4115E1B181665FC0B0DE003B8F409BY5PR12MB4115namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Christian,<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:10.0pt">Good to know, thanks ve=
ry much.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best wishes<o:p></o:p></p>
<p class=3D"MsoNormal">Emily Deng<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Christian K=F6nig &lt;ckoenig.leichtzum=
erken@gmail.com&gt;
<br>
<b>Sent:</b> Wednesday, April 28, 2021 5:07 PM<br>
<b>To:</b> Deng, Emily &lt;Emily.Deng@amd.com&gt;; Deucher, Alexander &lt;A=
lexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Sun, Roy &lt;Roy.Sun@amd.com&gt;; amd-gfx list &lt;amd-gfx@lists=
.freedesktop.org&gt;; Nieto, David M &lt;David.Nieto@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track=
<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Well none. As I said =
I will push this upstream through drm-misc-next.<br>
<br>
Christian.<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">Am 28.04.21 um 10:32 schrieb Deng, Emily:<o:p></o:p>=
</p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p style=3D"margin:5.0pt"><span style=3D"font-family:&quot;Arial&quot;,sans=
-serif;color:#0078D7">[AMD Official Use Only - Internal Distribution Only]<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Hi Alex and Christian,<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:10.0pt">What extra work Roy nee=
d to do about this patch? And fdinfo?<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Best wishes<o:p></o:p></p>
<p class=3D"MsoNormal">Emily Deng<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx <a href=3D"mailto:amd-gfx-bounc=
es@lists.freedesktop.org">
&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> <b>On Behalf Of </b>Deuch=
er, Alexander<br>
<b>Sent:</b> Tuesday, April 27, 2021 3:52 AM<br>
<b>To:</b> Christian K=F6nig <a href=3D"mailto:ckoenig.leichtzumerken@gmail=
.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
<b>Cc:</b> Sun, Roy <a href=3D"mailto:Roy.Sun@amd.com">&lt;Roy.Sun@amd.com&=
gt;</a>; amd-gfx list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesk=
top.org&gt;</a>; Nieto, David M
<a href=3D"mailto:David.Nieto@amd.com">&lt;David.Nieto@amd.com&gt;</a><br>
<b>Subject:</b> Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track=
<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-family:&quot;Arial&quot;,sans=
-serif;color:#0078D7">[AMD Official Use Only - Internal Distribution Only]<=
/span><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-family:&quot;Arial&quot;,sans=
-serif;color:#0078D7">[AMD Official Use Only - Internal Distribution Only]<=
/span><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Fair po=
int.&nbsp; Either way works for me.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;<=
/span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex</s=
pan><o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.lei=
chtzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
<b>Sent:</b> Monday, April 26, 2021 3:48 PM<br>
<b>To:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Cc:</b> amd-gfx list &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org=
">amd-gfx@lists.freedesktop.org</a>&gt;; Sun, Roy &lt;<a href=3D"mailto:Roy=
.Sun@amd.com">Roy.Sun@amd.com</a>&gt;; Nieto, David M &lt;<a href=3D"mailto=
:David.Nieto@amd.com">David.Nieto@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track=
</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">My concern is more to=
 get this tested from more people than just AMD.<br>
<br>
Christian.<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">Am 26.04.21 um 21:40 schrieb Deucher, Alexander:<o:p=
></o:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p style=3D"margin:5.0pt"><span style=3D"font-family:&quot;Arial&quot;,sans=
-serif;color:#0078D7">[AMD Official Use Only - Internal Distribution Only]<=
/span><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">That sa=
id, it would be easier for me to merge through the AMD tree since a relativ=
ely big AMD feature depends on it.&nbsp; Not sure how much conflict potenti=
al there is if this goes through the AMD
 tree.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;<=
/span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex</s=
pan><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;<=
/span><o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx
<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounce=
s@lists.freedesktop.org&gt;</a> on behalf of Deucher, Alexander
<a href=3D"mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&=
gt;</a><br>
<b>Sent:</b> Monday, April 26, 2021 3:24 PM<br>
<b>To:</b> Christian K=F6nig <a href=3D"mailto:ckoenig.leichtzumerken@gmail=
.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
<b>Cc:</b> amd-gfx list <a href=3D"mailto:amd-gfx@lists.freedesktop.org">&l=
t;amd-gfx@lists.freedesktop.org&gt;</a>; Sun, Roy
<a href=3D"mailto:Roy.Sun@amd.com">&lt;Roy.Sun@amd.com&gt;</a>; Nieto, Davi=
d M <a href=3D"mailto:David.Nieto@amd.com">
&lt;David.Nieto@amd.com&gt;</a><br>
<b>Subject:</b> Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track=
</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-family:&quot;Arial&quot;,sans=
-serif;color:#0078D7">[AMD Official Use Only - Internal Distribution Only]<=
/span><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-family:&quot;Arial&quot;,sans=
-serif;color:#0078D7">[AMD Official Use Only - Internal Distribution Only]<=
/span><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">No obje=
ctions from me.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;<=
/span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Thanks!=
</span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;<=
/span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex</s=
pan><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;<=
/span><o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Christian K=F6nig
<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumer=
ken@gmail.com&gt;</a><br>
<b>Sent:</b> Monday, April 26, 2021 2:49 AM<br>
<b>To:</b> Deucher, Alexander <a href=3D"mailto:Alexander.Deucher@amd.com">=
&lt;Alexander.Deucher@amd.com&gt;</a><br>
<b>Cc:</b> Nieto, David M <a href=3D"mailto:David.Nieto@amd.com">&lt;David.=
Nieto@amd.com&gt;</a>; Sun, Roy
<a href=3D"mailto:Roy.Sun@amd.com">&lt;Roy.Sun@amd.com&gt;</a>; amd-gfx lis=
t <a href=3D"mailto:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Subject:</b> Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track=
</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Hey Alex,<br>
<br>
any objections that we merge those two patches through drm-misc-next?<br>
<br>
Thanks,<br>
Christian.<br>
<br>
Am 26.04.21 um 08:27 schrieb Roy Sun:<br>
&gt; Update the timestamp of scheduled fence on HW<br>
&gt; completion of the previous fences<br>
&gt;<br>
&gt; This allow more accurate tracking of the fence<br>
&gt; execution in HW<br>
&gt;<br>
&gt; Signed-off-by: David M Nieto <a href=3D"mailto:david.nieto@amd.com">&l=
t;david.nieto@amd.com&gt;</a><br>
&gt; Signed-off-by: Roy Sun <a href=3D"mailto:Roy.Sun@amd.com">&lt;Roy.Sun@=
amd.com&gt;</a><br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/scheduler/sched_main.c | 12 ++++++++++--<b=
r>
&gt;&nbsp;&nbsp; 1 file changed, 10 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/=
scheduler/sched_main.c<br>
&gt; index 92d8de24d0a1..f8e39ab0c41b 100644<br>
&gt; --- a/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt; +++ b/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt; @@ -515,7 +515,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_schedu=
ler *sched)<br>
&gt;&nbsp;&nbsp; EXPORT_SYMBOL(drm_sched_resubmit_jobs);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt; - * drm_sched_resubmit_jobs_ext - helper to relunch certain number of =
jobs from mirror ring list<br>
&gt; + * drm_sched_resubmit_jobs_ext - helper to relaunch certain number of=
 jobs from pending list<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp; * @sched: scheduler instance<br>
&gt;&nbsp;&nbsp;&nbsp; * @max: job numbers to relaunch<br>
&gt; @@ -671,7 +671,7 @@ drm_sched_select_entity(struct drm_gpu_scheduler *=
sched)<br>
&gt;&nbsp;&nbsp; static struct drm_sched_job *<br>
&gt;&nbsp;&nbsp; drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)=
<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job, *next;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Don't destroy jobs w=
hile the timeout worker is running&nbsp; OR thread<br>
&gt; @@ -690,6 +690,14 @@ drm_sched_get_cleanup_job(struct drm_gpu_schedule=
r *sched)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job &amp;&amp; dma_fence=
_is_signaled(&amp;job-&gt;s_fence-&gt;finished)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* remove job from pending_list */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; list_del_init(&amp;job-&gt;list);<br>
&gt; We just need to record the scheduled time of the next job. So we<br>
&gt; need not to check the rest job.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* account for the next fence in the queue */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; next =3D list_first_entry_or_null(&amp;sched-&gt;pending_list,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job, list);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (next &amp;&amp; test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;job-&gt;s_fence-&g=
t;finished.flags)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next-&gt;s_fence-&gt;sc=
heduled.timestamp =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;s_fence-&gt;finished.timestamp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; job =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* queue timeout for next job */<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</blockquote>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</blockquote>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_BY5PR12MB4115E1B181665FC0B0DE003B8F409BY5PR12MB4115namp_--

--===============0036445437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0036445437==--

Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E2CC433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 19:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2988E613CB
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 19:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2988E613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B99546EC41;
	Wed,  5 May 2021 19:55:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D1FC6EC41
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 19:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S73zNDIhsAPKwl4v10G6ye1nFiso/Jq/+KWX1A2SS4CIOfOa0XNPNkktVO3CVpcg/THZhOjCo/i2R+4dSRGchvq1KB6Jlg8IDO7lq0ika5evY1vHYuJnz/sWM6c0XbkgcwdIY9sRLAofckS8LuGr3sIp3JEN1rsvLpj5pyRVPTUAMi1n5DiYVTuXeJul0jItUldD/wGb0jGvssKwNKOty49eZ5l06NukUMKNJkmrb5fyGt+bNBuGNHyFu65NEP4CrcgiwFYzlbDLGhrIoyJ3/pfyt56SSk5dXwADaepYtUuAZmvpjaW6z3P2AvUazNA3oD97JGt2egKm3zEZMvalUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uL5i6DKjyPbBNCPr7GdbO+Cp7QEhFsxbkMFW3rorBF4=;
 b=W0CxwVsJFscomwJbkd8inppC7Rj3XBNMk3elvCGc089J6fB6xjiiyTZ5hUtxayg1eWnZ3S7RbiKqKTvMDL11okpbBVMI+GHLqksCHgTOS/qnIKNDu8jKVd4yCdkATmJBywcpExRDcHP2P1uaw0Hn3ri4ru+7oOHI9HKVzS5oXocCXN3u7KkoA8X9iJfq4MQPYGrUbXvySzBkD1fQ5MPZ+FeWxKg+jb3Z07hpqzTZv1915h3cy+i9Bh923OUzs6zMiSNW7SFUnLyD1caStDetEb6kQDumcA1/53q6jXS8Yful7/GiWbbhywd0bV3krz/JaBABQjnTxeLbHmEQ+6gj/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uL5i6DKjyPbBNCPr7GdbO+Cp7QEhFsxbkMFW3rorBF4=;
 b=Xsl37ppO7Ge0rm5+tZv0ZaW16S/a+1lh/PvVXouA/nlwytZrKCUaWAYXCDomVVkdSCHlDWWWYhkYua2VCxiZYn2S7+H3DjBlV6xNT9Z5CHCHuaPZukXJQSsq3rDBSagCC7m4Hw5w5GTH2y2z0yv4DcKx9TNea+C5qllupAtvFYo=
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB3381.namprd12.prod.outlook.com (2603:10b6:a03:df::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 5 May
 2021 19:55:32 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 19:55:32 +0000
From: "Nieto, David M" <David.Nieto@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Thread-Topic: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Thread-Index: AQHXOmUqGJleZ/RB60WUXECj/KoFp6rGW78AgADS6QCAAASNAIAAAiGAgAABC4CAAmbWAIAACZYAgAorEYCAALmXAIAA0Lfb
Date: Wed, 5 May 2021 19:55:32 +0000
Message-ID: <BYAPR12MB28400AAEF6B34676B1CAD5E9F4599@BYAPR12MB2840.namprd12.prod.outlook.com>
References: <20210426062701.39732-1-Roy.Sun@amd.com>
 <8b8ec884-5b0b-3409-b7b0-be7da43e3e71@gmail.com>
 <MN2PR12MB4488F5277BF26669E8D8673BF7429@MN2PR12MB4488.namprd12.prod.outlook.com>
 <MN2PR12MB44884F5635594C3F53D3F865F7429@MN2PR12MB4488.namprd12.prod.outlook.com>
 <df0aa92d-87b9-7c27-f06f-9e1a10cead5d@gmail.com>
 <MN2PR12MB44880E0C0FA8C75D7E28884AF7429@MN2PR12MB4488.namprd12.prod.outlook.com>
 <BY5PR12MB41150F5816B764A3E619AB4F8F409@BY5PR12MB4115.namprd12.prod.outlook.com>
 <8529a53a-66ed-60a1-9ae4-279524e5a57f@gmail.com>
 <CADnq5_PUo1iCOV37LT=sJuC5edFWL1256DG4vHh7_kBOT9HfRA@mail.gmail.com>,
 <274b580b-de8b-09d7-e2d6-efe74230d7f3@gmail.com>
In-Reply-To: <274b580b-de8b-09d7-e2d6-efe74230d7f3@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-05T19:55:32.101Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.53.104]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 891c24c2-7e43-4448-1277-08d90fffbdc7
x-ms-traffictypediagnostic: BYAPR12MB3381:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB33811A960B9D6F0DCBA5CF4CF4599@BYAPR12MB3381.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I4xKXrNmJPuOSgitvvEQlpdLPvYG9psVRhhjGBIaNkYwUw2ejhObq+R7V1ZZkSOST4nmp93WjlXXZyi5ZI3P1l6NO5MvxFPlZ3cWEHUVrE3X8D1IoCeYMdfYXPaBbtGKI4YOEWKysXV1QjPqukTL1HhU3RfGRGVER9wlJVUinOBEd8rdODK+M9fZlCFf+HnqLeBCTdqqRwUNNbPRoDTKn1z/u7MK0560FbFDehGn37FPGeyjh//DAx9mRTY9qjzJ6mjzFPsG4prjrn1939dyF8jqGC5+Y/M5cq+Ug+QDTKksYwB/DqkVh9tT194H5a71ncRA/nF2BNBSiOVAt/vHhsp9qlwzcmL8fPpQLTnipzYYYqYZcuXV8YzRMltyquY2FFopkYyxOXLWUXnqNCNzNBrt69Og2ausCdcaE6UQD/OxMjc7P2QQzNP2g7/bUYZf4ziqVQWUly541M8JZ9L8yUt2qeOywViKmFcvaoVVw0JOfzBnZn+vMRrHwYcck89XbRCgYet5Il8bmpjZl7zYTahvj0nPCqk0vJoojptsQKfB+0A+QHrUYsNBJm+/KL1OjAlNJhNc3qA8c4EuJK87W8JPP7DfQ95JkkL0mn5L1PfnoW3zmjjZCNbz9CmZADjH+Xsy7YE0wisn2UthDOdFTQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(966005)(9686003)(8676002)(19627405001)(55016002)(66574015)(6506007)(76116006)(45080400002)(110136005)(186003)(4326008)(26005)(52536014)(66946007)(2906002)(54906003)(7696005)(5660300002)(53546011)(83380400001)(166002)(122000001)(478600001)(316002)(66476007)(71200400001)(86362001)(8936002)(38100700002)(66446008)(33656002)(66556008)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?v7/TSSxD8zOySnw+xWBXtLU6HQS6AF6oqHdScxIlEn6fEmD0DJnNXtZR6P?=
 =?iso-8859-1?Q?dkiYnayC5TKlI6r548LS7bcJM1xHVDYPSyL3FUcLs/4edhSPRo4TK7eCAy?=
 =?iso-8859-1?Q?bEkSWJ4QlC5hOFxMK4BuLHeqW57n1DXE1/dq1l5FZOADsi6Oy6r5Iq9oUE?=
 =?iso-8859-1?Q?U2H5TCfrf2v7PC+IFqI07nvNv/8mFvOnJjc66irwXNIoI3jvjxmAUyk7zp?=
 =?iso-8859-1?Q?WobFAc4gULBDIgvsvbkaYX5egGGNSMzo9d18YJlvJJ4pb6BFcJhyB/Gs2r?=
 =?iso-8859-1?Q?3DGJ0XJnIM2ZGf3cAczQ8iEkME/Zt5p5pgHkqJ1mzSQUe8SvuFzHsYQa0L?=
 =?iso-8859-1?Q?jDKO2b7WW5v+qqPaXL8FrE/jyKpyWBz65m3J1yqUPgwSAj/4k9WfXSzSJX?=
 =?iso-8859-1?Q?Pfd5dPO6FuC3RsTdjJjX0VD++MxLB+Rdb8pqEdqvuq29fsbppnOHT0MZKv?=
 =?iso-8859-1?Q?CmUg1cZe3Auqifl5scC12vv3kCwWg0FKiSamjXEcgIe1wtQbuuQ7BZ1MaY?=
 =?iso-8859-1?Q?6gjy4noPUNin/ByxeTngha96UgYWcXOMomNaGRZNqcK9jTDbd3WleB4lyF?=
 =?iso-8859-1?Q?Bnq6VpH6RkumOXDEX2PxILx2aAvarl08/eIJXyeuJTW2jDz+s2znrjrSc+?=
 =?iso-8859-1?Q?STnCgYfWUjRrXZaf+qAGwgTpkiEiZPUFPZjN+ZCxTJYRDMDjugNodoWEy9?=
 =?iso-8859-1?Q?Bg0zbOF9BHTQgQFzKhUwRQ0rc1a0f5PaurNzIT3FE2lGjygDM+CJGvjXso?=
 =?iso-8859-1?Q?tSnWXJ5/ExHB4q5oTpPvWA3P1Oc2XpkZ/CqsACzuII8CAlXHlP32dW+Zdf?=
 =?iso-8859-1?Q?ZqHsHun9Eri6uHRYolfrvV+sMaMkOvJRSRe+SKvZSanopppP82JwefLIpI?=
 =?iso-8859-1?Q?InFQ7lsqGYmwqE116Ymj8PqzDcPTI7HsdGL4Bkzb8V1HwW1GbSHy3jyYvY?=
 =?iso-8859-1?Q?gXns6GyAljjUKwsYASw+c6sdreM4qU7rnntjm3hYM4P6jwhap2qqzfP2Fu?=
 =?iso-8859-1?Q?8mZO3l/8IG52gktY2Jil2z40/WTsunvi4Rzpq74FWD4vRDiGN7yPiwc4M/?=
 =?iso-8859-1?Q?MCl6jO77P910boq6GuRpBF2S13Fc2/PVnZ4B/mfHvjRoNPmBCOJPtUOsTJ?=
 =?iso-8859-1?Q?+IlRKrTKIzpEs35rwxflRobiLhgmj6TFZmp/5g3UpDtmnu48T9TwQ3RZcp?=
 =?iso-8859-1?Q?UQWCW5FMAHnUxfsGuU/i9rIluW/pRxEHaER/OlybMT70+IPqt0QoQGjKjv?=
 =?iso-8859-1?Q?VYk5uL0OIbWTJwhiC1vwNnSHr7si/nvx/lcqkEfYblkCRqtWfU2vM2olEt?=
 =?iso-8859-1?Q?idaRh1bfgZPAXdHUKkzjgVP/JWwNo8/heeK84jzKj16iUztd8LHjrEllen?=
 =?iso-8859-1?Q?SKt7UCnaQR?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891c24c2-7e43-4448-1277-08d90fffbdc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2021 19:55:32.2694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MfBgKVEON8bDc/sZHVst/uXxU/QaMbaa6Nkxax5+wfGoITzceriJEboDtLax6F5E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3381
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Sun, Roy" <Roy.Sun@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0474533309=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0474533309==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB28400AAEF6B34676B1CAD5E9F4599BYAPR12MB2840namp_"

--_000_BYAPR12MB28400AAEF6B34676B1CAD5E9F4599BYAPR12MB2840namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thanks,

Do we know when those changes will make it back to amd-staging-drm-next ?
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Wednesday, May 5, 2021 12:27 AM
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Deng, Emily <Emily.Deng@amd.com>; Deucher, Alexander <Alexander.Deucher=
@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>; Sun, Roy <Roy.Sun@=
amd.com>; Nieto, David M <David.Nieto@amd.com>
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track

I had to rebase them and was on sick leave last week.

Changed a few things on patch #1 and pushed the result a minute ago.

Christian.

Am 04.05.21 um 22:23 schrieb Alex Deucher:
> Did you push this yet?  I don't see it in drm-misc.
>
> Thanks,
>
> Alex
>
> On Wed, Apr 28, 2021 at 5:06 AM Christian K=F6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Well none. As I said I will push this upstream through drm-misc-next.
>>
>> Christian.
>>
>> Am 28.04.21 um 10:32 schrieb Deng, Emily:
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>>
>> Hi Alex and Christian,
>>
>> What extra work Roy need to do about this patch? And fdinfo?
>>
>>
>>
>> Best wishes
>>
>> Emily Deng
>>
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Deuch=
er, Alexander
>> Sent: Tuesday, April 27, 2021 3:52 AM
>> To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
>> Cc: Sun, Roy <Roy.Sun@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.=
org>; Nieto, David M <David.Nieto@amd.com>
>> Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track
>>
>>
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>>
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>>
>>
>> Fair point.  Either way works for me.
>>
>>
>>
>> Alex
>>
>> ________________________________
>>
>> From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
>> Sent: Monday, April 26, 2021 3:48 PM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Sun, Roy <Roy.Sun@amd.=
com>; Nieto, David M <David.Nieto@amd.com>
>> Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track
>>
>>
>>
>> My concern is more to get this tested from more people than just AMD.
>>
>> Christian.
>>
>> Am 26.04.21 um 21:40 schrieb Deucher, Alexander:
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>>
>>
>> That said, it would be easier for me to merge through the AMD tree since=
 a relatively big AMD feature depends on it.  Not sure how much conflict po=
tential there is if this goes through the AMD tree.
>>
>>
>>
>> Alex
>>
>>
>>
>> ________________________________
>>
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Deuch=
er, Alexander <Alexander.Deucher@amd.com>
>> Sent: Monday, April 26, 2021 3:24 PM
>> To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
>> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Sun, Roy <Roy.Sun@amd.=
com>; Nieto, David M <David.Nieto@amd.com>
>> Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track
>>
>>
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>>
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>>
>>
>> No objections from me.
>>
>>
>>
>> Thanks!
>>
>>
>>
>> Alex
>>
>>
>>
>> ________________________________
>>
>> From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
>> Sent: Monday, April 26, 2021 2:49 AM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: Nieto, David M <David.Nieto@amd.com>; Sun, Roy <Roy.Sun@amd.com>; am=
d-gfx list <amd-gfx@lists.freedesktop.org>
>> Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track
>>
>>
>>
>> Hey Alex,
>>
>> any objections that we merge those two patches through drm-misc-next?
>>
>> Thanks,
>> Christian.
>>
>> Am 26.04.21 um 08:27 schrieb Roy Sun:
>>> Update the timestamp of scheduled fence on HW
>>> completion of the previous fences
>>>
>>> This allow more accurate tracking of the fence
>>> execution in HW
>>>
>>> Signed-off-by: David M Nieto <david.nieto@amd.com>
>>> Signed-off-by: Roy Sun <Roy.Sun@amd.com>
>>> ---
>>>    drivers/gpu/drm/scheduler/sched_main.c | 12 ++++++++++--
>>>    1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/s=
cheduler/sched_main.c
>>> index 92d8de24d0a1..f8e39ab0c41b 100644
>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>> @@ -515,7 +515,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_schedul=
er *sched)
>>>    EXPORT_SYMBOL(drm_sched_resubmit_jobs);
>>>
>>>    /**
>>> - * drm_sched_resubmit_jobs_ext - helper to relunch certain number of j=
obs from mirror ring list
>>> + * drm_sched_resubmit_jobs_ext - helper to relaunch certain number of =
jobs from pending list
>>>     *
>>>     * @sched: scheduler instance
>>>     * @max: job numbers to relaunch
>>> @@ -671,7 +671,7 @@ drm_sched_select_entity(struct drm_gpu_scheduler *s=
ched)
>>>    static struct drm_sched_job *
>>>    drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
>>>    {
>>> -     struct drm_sched_job *job;
>>> +     struct drm_sched_job *job, *next;
>>>
>>>         /*
>>>          * Don't destroy jobs while the timeout worker is running  OR t=
hread
>>> @@ -690,6 +690,14 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler=
 *sched)
>>>         if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
>>>                 /* remove job from pending_list */
>>>                 list_del_init(&job->list);
>>> We just need to record the scheduled time of the next job. So we
>>> need not to check the rest job.
>>> +             /* account for the next fence in the queue */
>>> +             next =3D list_first_entry_or_null(&sched->pending_list,
>>> +                             struct drm_sched_job, list);
>>> +             if (next && test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
>>> +                     &job->s_fence->finished.flags)) {
>>> +                     next->s_fence->scheduled.timestamp =3D
>>> +                             job->s_fence->finished.timestamp;
>>> +             }
>>>         } else {
>>>                 job =3D NULL;
>>>                 /* queue timeout for next job */
>>
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist=
s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CDavid=
.Nieto%40amd.com%7C7e7e640953954b94e2d408d90f9744a1%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637557964635531548%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DYk2XfdFcbeimlcdh3VXWldS1cRD9LA32PMlN0kbfUME%3D&amp;reserved=3D0


--_000_BYAPR12MB28400AAEF6B34676B1CAD5E9F4599BYAPR12MB2840namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Thanks,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Do we know when those changes will make it back to&nbsp;amd-staging-drm-nex=
t ?</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Wednesday, May 5, 2021 12:27 AM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;<br>
<b>Cc:</b> Deng, Emily &lt;Emily.Deng@amd.com&gt;; Deucher, Alexander &lt;A=
lexander.Deucher@amd.com&gt;; amd-gfx list &lt;amd-gfx@lists.freedesktop.or=
g&gt;; Sun, Roy &lt;Roy.Sun@amd.com&gt;; Nieto, David M &lt;David.Nieto@amd=
.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">I had to rebase them and was on sick leave last we=
ek.<br>
<br>
Changed a few things on patch #1 and pushed the result a minute ago.<br>
<br>
Christian.<br>
<br>
Am 04.05.21 um 22:23 schrieb Alex Deucher:<br>
&gt; Did you push this yet?&nbsp; I don't see it in drm-misc.<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt; On Wed, Apr 28, 2021 at 5:06 AM Christian K=F6nig<br>
&gt; &lt;ckoenig.leichtzumerken@gmail.com&gt; wrote:<br>
&gt;&gt; Well none. As I said I will push this upstream through drm-misc-ne=
xt.<br>
&gt;&gt;<br>
&gt;&gt; Christian.<br>
&gt;&gt;<br>
&gt;&gt; Am 28.04.21 um 10:32 schrieb Deng, Emily:<br>
&gt;&gt;<br>
&gt;&gt; [AMD Official Use Only - Internal Distribution Only]<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Hi Alex and Christian,<br>
&gt;&gt;<br>
&gt;&gt; What extra work Roy need to do about this patch? And fdinfo?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Best wishes<br>
&gt;&gt;<br>
&gt;&gt; Emily Deng<br>
&gt;&gt;<br>
&gt;&gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Beh=
alf Of Deucher, Alexander<br>
&gt;&gt; Sent: Tuesday, April 27, 2021 3:52 AM<br>
&gt;&gt; To: Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;<br>
&gt;&gt; Cc: Sun, Roy &lt;Roy.Sun@amd.com&gt;; amd-gfx list &lt;amd-gfx@lis=
ts.freedesktop.org&gt;; Nieto, David M &lt;David.Nieto@amd.com&gt;<br>
&gt;&gt; Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence tra=
ck<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; [AMD Official Use Only - Internal Distribution Only]<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; [AMD Official Use Only - Internal Distribution Only]<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Fair point.&nbsp; Either way works for me.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Alex<br>
&gt;&gt;<br>
&gt;&gt; ________________________________<br>
&gt;&gt;<br>
&gt;&gt; From: Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;<b=
r>
&gt;&gt; Sent: Monday, April 26, 2021 3:48 PM<br>
&gt;&gt; To: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
&gt;&gt; Cc: amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Sun, Roy &=
lt;Roy.Sun@amd.com&gt;; Nieto, David M &lt;David.Nieto@amd.com&gt;<br>
&gt;&gt; Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence tra=
ck<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; My concern is more to get this tested from more people than just A=
MD.<br>
&gt;&gt;<br>
&gt;&gt; Christian.<br>
&gt;&gt;<br>
&gt;&gt; Am 26.04.21 um 21:40 schrieb Deucher, Alexander:<br>
&gt;&gt;<br>
&gt;&gt; [AMD Official Use Only - Internal Distribution Only]<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; That said, it would be easier for me to merge through the AMD tree=
 since a relatively big AMD feature depends on it.&nbsp; Not sure how much =
conflict potential there is if this goes through the AMD tree.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Alex<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ________________________________<br>
&gt;&gt;<br>
&gt;&gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; on beh=
alf of Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
&gt;&gt; Sent: Monday, April 26, 2021 3:24 PM<br>
&gt;&gt; To: Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;<br>
&gt;&gt; Cc: amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Sun, Roy &=
lt;Roy.Sun@amd.com&gt;; Nieto, David M &lt;David.Nieto@amd.com&gt;<br>
&gt;&gt; Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence tra=
ck<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; [AMD Official Use Only - Internal Distribution Only]<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; [AMD Official Use Only - Internal Distribution Only]<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; No objections from me.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Thanks!<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Alex<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ________________________________<br>
&gt;&gt;<br>
&gt;&gt; From: Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;<b=
r>
&gt;&gt; Sent: Monday, April 26, 2021 2:49 AM<br>
&gt;&gt; To: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
&gt;&gt; Cc: Nieto, David M &lt;David.Nieto@amd.com&gt;; Sun, Roy &lt;Roy.S=
un@amd.com&gt;; amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
&gt;&gt; Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence tra=
ck<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Hey Alex,<br>
&gt;&gt;<br>
&gt;&gt; any objections that we merge those two patches through drm-misc-ne=
xt?<br>
&gt;&gt;<br>
&gt;&gt; Thanks,<br>
&gt;&gt; Christian.<br>
&gt;&gt;<br>
&gt;&gt; Am 26.04.21 um 08:27 schrieb Roy Sun:<br>
&gt;&gt;&gt; Update the timestamp of scheduled fence on HW<br>
&gt;&gt;&gt; completion of the previous fences<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This allow more accurate tracking of the fence<br>
&gt;&gt;&gt; execution in HW<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: David M Nieto &lt;david.nieto@amd.com&gt;<br>
&gt;&gt;&gt; Signed-off-by: Roy Sun &lt;Roy.Sun@amd.com&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/scheduler/sched_main.c | 12 =
++++++++++--<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; 1 file changed, 10 insertions(+), 2 deletion=
s(-)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/=
gpu/drm/scheduler/sched_main.c<br>
&gt;&gt;&gt; index 92d8de24d0a1..f8e39ab0c41b 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt;&gt;&gt; @@ -515,7 +515,7 @@ void drm_sched_resubmit_jobs(struct drm_gp=
u_scheduler *sched)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; EXPORT_SYMBOL(drm_sched_resubmit_jobs);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; /**<br>
&gt;&gt;&gt; - * drm_sched_resubmit_jobs_ext - helper to relunch certain nu=
mber of jobs from mirror ring list<br>
&gt;&gt;&gt; + * drm_sched_resubmit_jobs_ext - helper to relaunch certain n=
umber of jobs from pending list<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * @sched: scheduler instance<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * @max: job numbers to relaunch<br>
&gt;&gt;&gt; @@ -671,7 +671,7 @@ drm_sched_select_entity(struct drm_gpu_sch=
eduler *sched)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; static struct drm_sched_job *<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drm_sched_get_cleanup_job(struct drm_gpu_sch=
eduler *sched)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job, *next;<br=
>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Don't =
destroy jobs while the timeout worker is running&nbsp; OR thread<br>
&gt;&gt;&gt; @@ -690,6 +690,14 @@ drm_sched_get_cleanup_job(struct drm_gpu_=
scheduler *sched)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job &amp;&=
amp; dma_fence_is_signaled(&amp;job-&gt;s_fence-&gt;finished)) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* remove job from pending_list */<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del_init(&amp;job-&gt;list);<br>
&gt;&gt;&gt; We just need to record the scheduled time of the next job. So =
we<br>
&gt;&gt;&gt; need not to check the rest job.<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* account for the next fence in the queue */<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; next =3D list_first_entry_or_null(&amp;sched-&gt;pending_list,<=
br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job, list);<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; if (next &amp;&amp; test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;job-&gt;s_=
fence-&gt;finished.flags)) {<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next-&gt;s_fenc=
e-&gt;scheduled.timestamp =3D<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;s_fence-&gt;finished.timestamp;<br=
>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; }<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job =3D NULL;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* queue timeout for next job */<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; amd-gfx@lists.freedesktop.org<br>
&gt;&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;d=
ata=3D04%7C01%7CDavid.Nieto%40amd.com%7C7e7e640953954b94e2d408d90f9744a1%7C=
3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637557964635531548%7CUnknown%7CT=
WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%=
3D%7C1000&amp;amp;sdata=3DYk2XfdFcbeimlcdh3VXWldS1cRD9LA32PMlN0kbfUME%3D&am=
p;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01%7CDavi=
d.Nieto%40amd.com%7C7e7e640953954b94e2d408d90f9744a1%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637557964635531548%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM=
C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sd=
ata=3DYk2XfdFcbeimlcdh3VXWldS1cRD9LA32PMlN0kbfUME%3D&amp;amp;reserved=3D0</=
a><br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB28400AAEF6B34676B1CAD5E9F4599BYAPR12MB2840namp_--

--===============0474533309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0474533309==--

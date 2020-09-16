Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDF0C43461
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 22:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ADB120708
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 22:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uSXKYjqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADB120708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DE736E0D6;
	Wed, 16 Sep 2020 22:16:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CBBA6E0D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 22:16:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8LSnIxbSITsjWg/w4Y0atf14cafD7FAAfNHu13G05n2jMp2q/RTAVzI2taSxPtL9wIq/+5Dfg7AWz0kTJ+nbGrWoZXqzYazQ9Nc3PDK0B61+A9c9AqDj7FDntSL7jYc34F7csf5AawCIsU3+ze3JMgrmgzsoEZY89vqZvIroQ+/+6p498OeuEYD6krfk1qoQbCj5oxXdo47moHJgpVCi72D1R2B6hggg1TrNMAjvOMXWBeaemZS/1NLxUKeXGBFj2EVLEDT4AMlLn6lCFWZhA0ykQ4DemrABh+u4oeXzC5dF2By/bMKHnPOEL3ByTm+aC4j51KJHnzDO9CRhv3xaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvuZyjKnKrgZ71NY89R5jMLBwmVP0giIC3uMbbV2C3g=;
 b=k1MG5ZEewc6rea9SRO2NbplehD3hsE/v6T7jN8SvzU4LR166CA/AYjrYB4sFsEWaaHRfi6Twty3KxZITqCekXQGiAhvpKsaVi5eJBgRvfak8Jd4ld9qOCCPqD96jS0qeqYGN6CTuVQP/Ih1jjW8yWIX9jC9g7FFuH3qmqbinA1p/kc9r85Y+4fCpO0zaMpb88ewpTxy0N8I/gl+cEAkys2+gFW5Syjv3tXQ8fDU3BC2K6827QEOu5DzwifUs1AH/G8KTvAduAfrpo8SIVX0149J3n3nQEkpDYLmahHCM3EWhgQ+DItM7RcPuA1PDkEBdS2DwiX8b+4XIGFuye6w7Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvuZyjKnKrgZ71NY89R5jMLBwmVP0giIC3uMbbV2C3g=;
 b=uSXKYjqmh9z50cjucm6QWX2ROaG+4HtPkBHbqF3mwcrwY73I4uLzQTOem9IPwlfwE0nLyW4k6nHXkV6WYWRtJqV1TlzaduN38OuCrwpoQX2MTjWGjd06ZMdOn2G4Ic3SrLzN2flgM07JVsDlNp1I/Z2Zhej/ag6cvoXCzCzuPLc=
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3402.namprd12.prod.outlook.com (2603:10b6:5:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Wed, 16 Sep
 2020 22:16:27 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::d0e:8fca:e862:1f05]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::d0e:8fca:e862:1f05%6]) with mapi id 15.20.3391.011; Wed, 16 Sep 2020
 22:16:27 +0000
From: "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 04/15] drm/amd/display: Replace msleep with udelay while
 read edid return defer.
Thread-Topic: [PATCH 04/15] drm/amd/display: Replace msleep with udelay while
 read edid return defer.
Thread-Index: AQHWjGC1UduKz8mDykmlsJcMNv3i8KlryXeAgAAHQHA=
Date: Wed, 16 Sep 2020 22:16:27 +0000
Message-ID: <DM5PR12MB1884F92A66DDF75EE2C770B5FB210@DM5PR12MB1884.namprd12.prod.outlook.com>
References: <20200916193635.5169-1-qingqing.zhuo@amd.com>
 <20200916193635.5169-5-qingqing.zhuo@amd.com>
 <CADnq5_O+rFANJbv1sN8SzGfyQ_kbv7xpeaSvhOKvtOSG0ui+ZA@mail.gmail.com>
In-Reply-To: <CADnq5_O+rFANJbv1sN8SzGfyQ_kbv7xpeaSvhOKvtOSG0ui+ZA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-16T22:13:52Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b0dd121d-7708-4958-af97-0000c5f2ca5f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-16T22:16:23Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: bf260547-d142-43e0-b7a7-00008777f5a5
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc552e2f-aaa7-4510-4fd1-08d85a8e281c
x-ms-traffictypediagnostic: DM6PR12MB3402:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB34025F27DDDBCC1545E16DEAFB210@DM6PR12MB3402.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3HG3QhaDQNjmkiGDlht7JAS7jWbUZpYmg7eLcuZvogetcjrfFOYsVhGqJuxyeNGsPJQauCtw2RHcJF3UATs9XO2TlL0THs5IHoHuaOTHfirHEolgkCJFk1hbAthH2VyQ5qp5T2Tmp8Zdlx3X1Pvc13l6b1LRWKb7mH+eZjs3eZk7lQpnNHjTpvRw7GF5fxQm9bhHAXWLjUX+l7mmHxlpyCrlEbyG7arBdldxe2E0KoK3ujGBs5UkOVDwDmuJB6vzdewy4SqddON4D8X3E2Cfctd5yr9c7/ko8oT3uN8jvkbcLji3wxp74EihdZXulfaAbd9/wnE35UN+92rFvQnHXfL1HFu6twmZHi3R1J/zQdHrcVxFOBunwas5l7U74OlrEg82Trdy2lfoYOX9n1/Qug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39850400004)(346002)(366004)(5660300002)(478600001)(52536014)(83080400001)(9686003)(71200400001)(55016002)(45080400002)(76116006)(4326008)(316002)(6916009)(33656002)(66946007)(64756008)(66556008)(66446008)(7696005)(2906002)(54906003)(66476007)(26005)(966005)(8936002)(86362001)(186003)(53546011)(8676002)(6506007)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 7mmWNk3w/tnMN+tWdi60CCR8LroffXTxHoHyHcgGgz5Xsp7fn7AaAFMSQpr23w9wg6NLyAJsa0E6icLQacOthenAemCxtfEMzdDWyXM4zruBcuVbPbufkrB2NalVD7WUu9rjJs0ZuBy/V6qWIFpX36Zs7snfyWiObEyLls6f+wDN/WV/rvrb5Lw15dHJj+JYNU1P9DALLUaiPDAM7kLf5OhL/eweQOa/+Rzx9UtCI7wB/8EZzA9p4ce5SNOqDCnz58OCUSPEyyCkporArW0Chvggypj96maSrO3Oje/sCO+bJ1vihHtY2EZBX5Riv4zzPQItuLDqwJhd1LtgcfWvD/epZhrOeeCym2V5t9yIXLmGJBCUGPuxZL068hzS79tiXP0rlFeXk+tqYyTlydte80HNm/hCm2NPUUaEWpJbkgIDymdZ3AkB9BgbkYMZ1quYQKs3F9VGZTPu+1zsn07mzH1zDNDFzvyIo20Qi6LsXjesTlnTvmQqpsvnbNVXgs/zpZH+7Stvp1ZGWY/XBnjkHrknF4f1KYQqmRyo2NN8zStzy/+IKUG9aTDY/4TefgaJVNfF9cMTMr+28T4cnuUsFGFzrQugPla840uGJH4WjLfnDcRBVSEBleOtmqHU14EYy/WSSu6I+4iFTbcAWi7twA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc552e2f-aaa7-4510-4fd1-08d85a8e281c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 22:16:27.6575 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JDcB09Rxk9zeckDUXWf8NwtQl7gYrRrZb3Ntu2u0gRcz5T8fAAIlhjE8eUyHdquQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3402
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
Cc: "Brol, Eryk" <Eryk.Brol@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha, 
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Jinlong" <Jinlong.Zhang@amd.com>, "Wentland, 
 Harry" <Harry.Wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

On Wed, Sep 16, 2020 at 3:42 PM Qingqing Zhuo <qingqing.zhuo@amd.com> wrote:
>
> From: jinlong zhang <jinlong.zhang@amd.com>
>
> [why]
> while read edid return defer, then it enter to msleep, but it actually 
> took more time during msleep, this will cause remaining edid read 
> fail.
>
> [how]
> Replacing msleep with udelay, it will not take any extra time, edid return pass finally.

How long of a delay are we talking about here?  Some platforms don't support long udelays and someone will send a patch to change this to msleep.

Alex

---------------------

Hi Alex,

It's between 0-5ms for generic cases, though there exist some dongle workaround cases where we will do 70ms. Would this be a concern?  

Thank you,
Lillian


>
> Signed-off-by: jinlong zhang <jinlong.zhang@amd.com>
> Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
> Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c 
> b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> index 743042d5905a..cdcad82765e0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> @@ -653,7 +653,7 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
>                                         if ((*payload->reply == AUX_TRANSACTION_REPLY_AUX_DEFER) ||
>                                                 (*payload->reply == AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER)) {
>                                                 if (payload->defer_delay > 0)
> -                                                       msleep(payload->defer_delay);
> +                                                       
> + udelay(payload->defer_delay * 1000);
>                                         }
>                                 }
>                                 break;
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cqi
> ngqing.zhuo%40amd.com%7C36c3bee68c28448769fa08d85a884619%7C3dd8961fe48
> 84e608e11a82d994e183d%7C0%7C0%7C637358888627498307&amp;sdata=mynpHpiup
> J%2FU2o5gZNW%2Bft%2Fg2beFY86%2BzMRWoTZCghQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

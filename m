Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5627FC43461
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 13:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1DB2083B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 13:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KS9A2mID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1DB2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 798DF6EC14;
	Thu, 17 Sep 2020 13:02:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84B4F6EC11
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 13:02:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWC/OScpHZ3dG8rm6YEuY6b20orK7e8kLgBntirmV2T8UMJKCMM7JIZn7INYjB2dclbQfZ7btbMM5wFmijNJU7SLOzDm0zIBT3MkxrSbeq8ul2HdnMvEV0hvYeVcHcx5V32NEVWFPRYi++gxiN8YqfAkRY6oKM6osMsLrTqI9OLNrOoTUH4yyXYTGOo13k0Gy631NwN8TXjfhYHrlChdeGWO6ObvwB36ifMc4i7D7zoPkm1T5nXMg2lBw/bLdaRgcirwyKU549tPe/BOuTer28y8Pvlcgz8C9db194TgkbGS3qh/HK20BXhh8z/Itw86OY0d7CdN2oZdtF7hv2GoZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtgZ0eW5zHTF2zAm6p5riLqvYYYbDsv19f+LnzJkEjQ=;
 b=kBuxzvyqEE65P7PZzdZPp0qXAnSOUgpE/EtSibbcmxCjHQ27m0n8QxpRhYA6kKAg9y0uGBdQqFRtkqdiaeCKJ2lAP5Jnc9s3Hjrl7Qpn/h1qXVTkUi+7B1tHEiyx7WHpNjDSWtD9JWqVb17LkDkdPyjhGln5eiCX6lvAHCWb8BMg2/xPX9Ok0X/N/PPOsFEFoV4WAKmcmBXbQVo49KD23YCduCor2Z/sb25N3VzVmuv0m/q0RA2JnrTCgR7rwxNAovcFSLBAHyHBUXQj+XYQRNekK2nDn0M/6yD8HLzGPj1iHszQ4P9Iv4y0LaGCLBROPlNdU9EaWi+DWRdUZUKckg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtgZ0eW5zHTF2zAm6p5riLqvYYYbDsv19f+LnzJkEjQ=;
 b=KS9A2mIDK9+pc0NBoIry8myaPJnt08P5UclSXWOdEF/t+6t0I41iWEmsFaKuTBOdEImLOy3IFQpZkcljk/F2urqLDeeyFlmcX2VxVAyijIV+LgjfWT+AXygwcilEzAKnRHOcmbPINepKQPrwuNHy9cjctKYVzY2fWytzbaF2YjE=
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB2809.namprd12.prod.outlook.com (2603:10b6:5:4a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 13:02:10 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::d0e:8fca:e862:1f05]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::d0e:8fca:e862:1f05%6]) with mapi id 15.20.3391.011; Thu, 17 Sep 2020
 13:02:10 +0000
From: "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
Subject: RE: [PATCH 04/15] drm/amd/display: Replace msleep with udelay while
 read edid return defer.
Thread-Topic: [PATCH 04/15] drm/amd/display: Replace msleep with udelay while
 read edid return defer.
Thread-Index: AQHWjGC1UduKz8mDykmlsJcMNv3i8KlryXeAgAAHQHCAAAUXgIAAqgaAgABK5OA=
Date: Thu, 17 Sep 2020 13:02:10 +0000
Message-ID: <DM5PR12MB1884C1E88327D7E903BC851CFB3E0@DM5PR12MB1884.namprd12.prod.outlook.com>
References: <20200916193635.5169-1-qingqing.zhuo@amd.com>
 <20200916193635.5169-5-qingqing.zhuo@amd.com>
 <CADnq5_O+rFANJbv1sN8SzGfyQ_kbv7xpeaSvhOKvtOSG0ui+ZA@mail.gmail.com>
 <DM5PR12MB1884F92A66DDF75EE2C770B5FB210@DM5PR12MB1884.namprd12.prod.outlook.com>
 <CADnq5_NFc+wdWLeb+aQ3QNHW7BZOXYHjCh-jzMRYTvRWBidLxA@mail.gmail.com>
 <80b70e69-8489-5f5f-a5a9-3f91431cdcfc@gmail.com>
In-Reply-To: <80b70e69-8489-5f5f-a5a9-3f91431cdcfc@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-17T13:02:05Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b0b6abea-888f-47a1-b2a2-00009bdd7386;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-17T13:02:05Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 275875a2-b5ff-4f81-8374-00000372d680
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a8763169-dc62-4780-23a6-08d85b09e3a6
x-ms-traffictypediagnostic: DM6PR12MB2809:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB28090C02F2E075497735981AFB3E0@DM6PR12MB2809.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V7yEjbr5gFBBh8peVtUvyyqpCfp3zUNHlX3Q211Cfx1p98A8Btqkwr65w/XsZQw4YmvNyQTafY8MFbbpOGzxfn7bN+9dPVEMdxUL+BcnSPhj+Z4P3FsUj6WdJ/ojPPV96q3ARzxHnNl/w0qLLzS/g+OHBAilbQ96T3JpSFiPl7Q4U45V5QLhvfbJuZ+wKbLqU79oLcAMRD9j8rcOeS9yM7ToxRizlThiy8DMXh4+CjxJ7g8bkFuhY5LdbnbqrfxnWl83RGvGH5Y1hfJ/tYs9gtmYqvJNAh1Hi7chBFac2npjL12NxlNZFnRVRybpvd/pc9MT2SWlQevy0TMA7EXvSsN27i+GG9hGNMSi2oM1GH44LCpymG00i9m6nnN+ujzUgJyG+u0m2/v9Rv9AM4EakA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(71200400001)(83380400001)(9686003)(55016002)(4326008)(83080400001)(45080400002)(316002)(966005)(33656002)(86362001)(52536014)(66476007)(66556008)(478600001)(8936002)(110136005)(54906003)(7696005)(64756008)(6506007)(5660300002)(76116006)(8676002)(2906002)(53546011)(66446008)(66946007)(186003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: XUZKuCfxdU0TwDzmQ1oZfhOqm4snHXt9OxiBBIjaKs+NdbiCZ2YBbBuVbCGafRMumQIzfwB2h0c3CSZQmujULAvg46KlUKD7/NyaiFcIpsVBkQVpWSLQGDesqDLK5xTL3Fcl9xTvK3aa/T4ocP7u96wLckkcgg1jdtgo7h3Y8TH0zMPqkEDFZwkQxPtAeeyohF2FDwM2yu++6k7LNtHqTHfvFiBgTkk9V63w5Ddhztknd2LL6iIiqxv7jCDvFTaqOrPpnlswmKT+hs2lrfcX5m3ramKZvmP1oyRggYJZDi7cNzXK/0COXfJH3qQjoCMrzMRB3psCEOik1vCRrrmaKJMERftfzHrLdSvl0Pv5WYPw7AQesxBISHymPpNL/DRCiGvpofasqL6G2rHzimp4PYGpjZsiLp7K8cw4CZzpgDvIZS/CChdegly+GtRPHUte/xfMWEV2S2qvbNGpR0weNyLFoxBuuJbS/6RzA7f86udk9jIHtEQRvOf68tJVt9zRmZR3UM3IXyBLAyYwc7gAwO5cnyl3cnRtsWFe7+jcnFdl7fTECfoftAtCqtxqP9rSF/lQ3c3HUFMkRt1/Zy9M4C24MIKhV78oBxqs2Xmz5WoM1HxE+1iuOCe/kiokkA4XPUk+ztq/eGQnaYhJu7bOAQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8763169-dc62-4780-23a6-08d85b09e3a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 13:02:10.3085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A2SAeeGYJmQSI05WYi6dZW2alkZR6DaMhv4Z5gRwjw7LxpT3K2JqJBOCnIvbB3hq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2809
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
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Jinlong" <Jinlong.Zhang@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Am 17.09.20 um 00:18 schrieb Alex Deucher:
>> On Wed, Sep 16, 2020 at 6:16 PM Zhuo, Qingqing <Qingqing.Zhuo@amd.com> wrote:
>>> [AMD Official Use Only - Internal Distribution Only]
>>>
>>>On Wed, Sep 16, 2020 at 3:42 PM Qingqing Zhuo <qingqing.zhuo@amd.com> wrote:
>>>> From: jinlong zhang <jinlong.zhang@amd.com>
>>>>
>>> >[why]
>>>>while read edid return defer, then it enter to msleep, but it 
>>>>actually took more time during msleep, this will cause remaining 
>>>>edid read fail.
>>>>
>>>> [how]
>>>> Replacing msleep with udelay, it will not take any extra time, edid return pass finally.
>>> How long of a delay are we talking about here?  Some platforms don't support long udelays and someone will send a patch to change this to msleep.
>>>
>>> Alex
>>>
>>> ---------------------
>>>
>>> Hi Alex,
>>>
>>> It's between 0-5ms for generic cases, though there exist some dongle workaround cases where we will do 70ms. Would this be a concern?
>> I think ARM has a limit of 2ms for udelay.

> Yeah, there is even a define somewhere for this.

> If you need a delay which is longer than this but still more precise than msleep() then there is the high precision timer sleep as alternative.

> I've forgotten the function name to use here, but there was a LWN article about this a few years ago. You just need to google a bit.

Hi Alex and Christian,

Thanks a lot for the input! Given what's been discussed, I will drop this patch for now.

Regards,
Lillian

>
> Regards,
> Christian.
>>
>> Alex
>>
>>> Thank you,
>>> Lillian
>>>
>>>
>>>> Signed-off-by: jinlong zhang <jinlong.zhang@amd.com>
>>>> Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
>>>> Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
>>>> ---
>>>> drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
>>>> b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
>>>> index 743042d5905a..cdcad82765e0 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
>>>> @@ -653,7 +653,7 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
>>>>                                          if ((*payload->reply == AUX_TRANSACTION_REPLY_AUX_DEFER) ||
>>>>                                                  (*payload->reply == AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER)) {
>>>>                                                  if (payload->defer_delay > 0)
>>>> -                                                       msleep(payload->defer_delay);
>>>> +
>>>> + udelay(payload->defer_delay * 1000);
>>>>                                          }
>>>>                                  }
>>>>                                  break;
>>>> --
>>>> 2.17.1
>>>>
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx@lists.freedesktop.org
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fli
>>>> st 
>>>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7C
>>>> qi
>>>> ngqing.zhuo%40amd.com%7C36c3bee68c28448769fa08d85a884619%7C3dd8961fe
>>>> 48 
>>>> 84e608e11a82d994e183d%7C0%7C0%7C637358888627498307&amp;sdata=mynpHpi
>>>> up
>>>> J%2FU2o5gZNW%2Bft%2Fg2beFY86%2BzMRWoTZCghQ%3D&amp;reserved=0
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CQi
>> ngqing.Zhuo%40amd.com%7Cd4acd0d5e65c49a7270f08d85ae37036%7C3dd8961fe48
>> 84e608e11a82d994e183d%7C0%7C0%7C637359280197936127&amp;sdata=ahcoCqG91
>> EDMNlHNSk4Eimh1azMtRWSX%2BKyHCdpFq1Q%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

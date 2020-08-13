Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F153AC433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 11:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C48EC208B3
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 11:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ywWAOiWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48EC208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 726EA6E9C0;
	Thu, 13 Aug 2020 11:33:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AA2C6E9C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 11:33:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoyaYg5D+W0pwiJ588d6YgRfX9we1Uof+scxzTxZHPiptYAlmV6ig9hMkF5cP3pXjpwrVT0pmr/SOeeOEifncslkNe0LhxgyVDwTav4ZNVTWdhaHNoZB8s3u1nqLykT+ev9mO95s+ThyrkVRc1kCcelXM8RCz5Bvbu7ji8nokD8aUog9gvrYJHrEX2oa/upHHRIZSldAACI6hJiQNq+pnzq8bc07C9ouQpmbR6wL0D/boJCEIOTlmy5hqilH7DXaRoL70OWIIZD6fk7Skp85iQk8pYo6EGn81dkYR8gUaWJa11HyswLtl3BrLKWxgY1XoxcZadRSJRwDp7O59Y3vQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRRIsor+mwUX94SDBlDt0nT6PYS9YHCpcehcuSWZ25Q=;
 b=k48iqvM7xCP9Y8WVU9DuxLjP7SR2JGalk54WVpTyU/NWbbBWXSYp0dSsc4HyU6IW4DyRprqkw1Ok2qkDF23rZIkXi/XaLB1L7/Qv7k1fqvkadiyobMQhvQL1inUWTwbxqS88oAonPpOBWqhrCF86C714h4/RzdZ34B8GfQ/QyEf1JGsRv9odSvYWOdTpYhO/kOyAUjPrDdXamQ+9XHzc5ibqLJE5BJBrhqX+dagabH1kgXFwoVKr9EjvWIQ9ITv/bVeI6NPES43WGDaRdSKL6FAEAaimC2Ep9psWK/z0nqrBLx1nAP2l0TINytJU1X917F5liGxHi2iRhzLXzZjlug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRRIsor+mwUX94SDBlDt0nT6PYS9YHCpcehcuSWZ25Q=;
 b=ywWAOiWDh/FzjR+nyAKwly7vxvLfAUecabXG9ClDLfRmKFTWfbEF+Qaa7/ZvRh+D/6hj9gWcO8Be1lhL434U0yeWRo+XQCVwGDYpc0ZmPQ+/PxEjD5NYehTtBxzUtAfji0uCAYcXZ6UIuswptU+n43Aqk+27Zc4tOtxKBTlaXss=
Received: from MN2PR12MB3549.namprd12.prod.outlook.com (2603:10b6:208:107::17)
 by MN2PR12MB3487.namprd12.prod.outlook.com (2603:10b6:208:c7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Thu, 13 Aug
 2020 11:33:15 +0000
Received: from MN2PR12MB3549.namprd12.prod.outlook.com
 ([fe80::d82b:d4a2:7ef2:c42d]) by MN2PR12MB3549.namprd12.prod.outlook.com
 ([fe80::d82b:d4a2:7ef2:c42d%3]) with mapi id 15.20.3261.026; Thu, 13 Aug 2020
 11:33:15 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "Quan, Evan"
 <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: Fix uninitialized warning in arcturus
 ppt driver
Thread-Topic: [PATCH] drm/amd/powerplay: Fix uninitialized warning in arcturus
 ppt driver
Thread-Index: AQHWcKMBwaE+m4TZeEmsKDw7aj6cEak1S9SAgAALFwCAAJLHTg==
Date: Thu, 13 Aug 2020 11:33:15 +0000
Message-ID: <MN2PR12MB3549DA1D217AB0AA2AE56F85F7430@MN2PR12MB3549.namprd12.prod.outlook.com>
References: <20200812122030.215907-1-tom.stdenis@amd.com>,
 <DM6PR12MB2619E6D6AD9439DDA1FB72B6E4430@DM6PR12MB2619.namprd12.prod.outlook.com>,
 <MN2PR12MB3022A54F624AF49FE9B2C9CDA2430@MN2PR12MB3022.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3022A54F624AF49FE9B2C9CDA2430@MN2PR12MB3022.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-13T11:33:14.755Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ac3c4f4-bda6-4d9d-7448-08d83f7cab2c
x-ms-traffictypediagnostic: MN2PR12MB3487:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3487856A0A4915CC11619D59F7430@MN2PR12MB3487.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:191;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ubXhLd5A1uSinTcsjL5lTLkEz4SceIIXxQNGWDr4YVW0dZsPBO7kCK9WGmgtIjQhYahOsJMaHiSCEqzI2lMwhHL6sckRf5VT/R2dbeGTjLOwFVV9scTa9JsiMxt8tNLSrOAlwPjZ7GdAnKR2ipNRhEtIRrXOffEo3tfTlR1iRxWUAlvm9NX3zbgZwn+miDSOSNafA57gDvaFJI6htqi/yp9NcGobTnGOlPLM+fCZ6vEKgdWA+551PT+Q2hFN6YWj2ynaZQ2fAwOj62YklV7zatBLA1B8AuFs+Wf7BRSfYT7WnS1RqjOx+evg029ZTLAsdvC4+gSYgNaprygAl1rRAbcSPQdVlxhUU2nEAPh3KGg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(8936002)(8676002)(9686003)(2906002)(55016002)(966005)(110136005)(478600001)(316002)(45080400002)(52536014)(83380400001)(86362001)(66446008)(66556008)(66946007)(64756008)(66476007)(76116006)(5660300002)(7696005)(71200400001)(186003)(26005)(53546011)(6506007)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: rTxvJNds91aUiJVQgGCDk0TJH+EdhTr/5rqDwfip1OEoqNL5pljgZkZiHz5ix2UMzoj7LyPcoVieA7nuXkZvvYQ80ufhqgGeUCjrQ5pjqtIWdg7S9LjUQBFBGktVAAFXPav3Kne/w7EHZetaiStXS/wFLcD1OlF7GivXqGxloX5BwzjxffpzxicU/ADVNH4cE6V52DfkXfPCQZncs4gyv+cdhNlqbJPXDR7TvR740AzMKlY+Cj58K662mlSDTzPuLjbfOeOYLYbQUMkeaovWmrAcszQ/b6fjqJGBt61tJQvjPEQX+P7i8p5FryxlG6sGRfIlQX7YaKpAh6TjNFZxe72qI+qZQdIuV8tsvX67wdny98FqWQQhSIUXuYr3U51Evv++C4fYpkLqgPw12oSiB9d+x5ulpgPNm2YIoGZXzGbidzyGzXWLiUPpn7jaao8o7aBo7glEnKcJSJZQctP61wfcfxalieDkBn6hepB71JOBih5y4eCFRJk2M6cJl70iqaKeAGKL4L4SpM4a+FtU9j6o34Mjy52ENmRJaEFm3m5meODdqrawQrJeH7l/gzyGYYoU+FpywYfmQpbIbtQ2/Qbirsm/VPqbStcWIkoedpTHFfZ5eqyNgDP7dhq26DF3t/FJC3nzPodH2TKTmDTO9g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac3c4f4-bda6-4d9d-7448-08d83f7cab2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 11:33:15.1518 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T5ZZEB3V9Su6gPd6iOUrFJfP4QOti/ckCpY83zn8nqpeLWVuYsDPdZPoKYzodUgFqGev6k7ytu+N+w82BWXGOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3487
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Kevin,

Ah ok disregard the (v2) I just sent then :-)

Thanks,
Tom

________________________________________
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Wednesday, August 12, 2020 22:47
To: Quan, Evan; StDenis, Tom; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amd/powerplay: Fix uninitialized warning in arctur=
us ppt driver

[AMD Official Use Only - Internal Distribution Only]

Hi Tom,

drm/amdgpu: fix uninit-value in arcturus_log_thermal_throttling_event()

the fixed patch has been merged into drm-next branch.

Best Regards,
Kevin

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Quan, Ev=
an <Evan.Quan@amd.com>
Sent: Thursday, August 13, 2020 10:07 AM
To: StDenis, Tom <Tom.StDenis@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: StDenis, Tom <Tom.StDenis@amd.com>
Subject: RE: [PATCH] drm/amd/powerplay: Fix uninitialized warning in arctur=
us ppt driver

[AMD Official Use Only - Internal Distribution Only]

[AMD Official Use Only - Internal Distribution Only]

Your change below should be able to suppress the compile warning.
-arcturus_get_smu_metrics_data(smu,
+ret =3D arcturus_get_smu_metrics_data(smu,
       METRICS_THROTTLER_STATUS,
       &throttler_status);

+if (ret) {
+dev_err(adev->dev, "Could not read from arcturus_get_smu_metrics_data()\n"=
);
+return;
+}
+
Setting *value as 0 may be unnecessary.  However anyway this patch is revie=
wed-by: Evan Quan <evan.quan@amd.com>

BR
Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tom St D=
enis
Sent: Wednesday, August 12, 2020 8:21 PM
To: amd-gfx@lists.freedesktop.org
Cc: StDenis, Tom <Tom.StDenis@amd.com>
Subject: [PATCH] drm/amd/powerplay: Fix uninitialized warning in arcturus p=
pt driver

Fixes:

  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_typ=
es.o
drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c: In function =91arct=
urus_log_thermal_throttling_event=92:
drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c:2223:24: warning: =
=91throttler_status=92 may be used uninitialized in this function [-Wmaybe-=
uninitialized]
 2223 |   if (throttler_status & logging_label[throttler_idx].feature_mask)=
 {

by making arcturus_get_smu_metrics_data() assign a default value (of zero) =
before any possible return point as well as simply error out of arcturus_lo=
g_thermal_throttling_event() if it fails.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c
index 8b1025dc54fd..78f7ec95e4f5 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -551,6 +551,9 @@ static int arcturus_get_smu_metrics_data(struct smu_con=
text *smu,

 mutex_lock(&smu->metrics_lock);

+// assign default value
+*value =3D 0;
+
 ret =3D smu_cmn_get_metrics_table_locked(smu,
        NULL,
        false);
@@ -2208,15 +2211,20 @@ static const struct throttling_logging_label {  }; =
 static void arcturus_log_thermal_throttling_event(struct smu_context *smu)=
  {
-int throttler_idx, throtting_events =3D 0, buf_idx =3D 0;
+int throttler_idx, throtting_events =3D 0, buf_idx =3D 0, ret;
 struct amdgpu_device *adev =3D smu->adev;
 uint32_t throttler_status;
 char log_buf[256];

-arcturus_get_smu_metrics_data(smu,
+ret =3D arcturus_get_smu_metrics_data(smu,
       METRICS_THROTTLER_STATUS,
       &throttler_status);

+if (ret) {
+dev_err(adev->dev, "Could not read from arcturus_get_smu_metrics_data()\n"=
);
+return;
+}
+
 memset(log_buf, 0, sizeof(log_buf));
 for (throttler_idx =3D 0; throttler_idx < ARRAY_SIZE(logging_label);
      throttler_idx++) {
--
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7Cf47512097dfc40168e1a08d83f2db359%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637328812813110771&amp;sdata=3DxedbRrZeOi0PK3EM%2FKBYhfX=
xdfpOkocXPjQjcQ5ErI0%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7Cf47512097dfc40168e1a08d83f2db359%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637328812813110771&amp;sdata=3DxedbRrZeOi0PK3EM%2FKBYhfX=
xdfpOkocXPjQjcQ5ErI0%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

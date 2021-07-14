Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AD8C07E9A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 13:29:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B228360230
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 13:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B228360230
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C78B6E2D5;
	Wed, 14 Jul 2021 13:29:26 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2074.outbound.protection.outlook.com [40.107.212.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFAFB6E2D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 13:29:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLC4b6s3f9VxRNJX4SK69HFpgsV3Jc2NUtPp63XPq8ZaO0sOjmdJx1xJvTLeDka1DFDKw48qVk19mYx0iemeiJSxxxKgq+hkxKKKsx8A5l5r5qxtpduMYxZmi6NRw2qu5Z8Hlw7xl2AbB+Em+WlvyVVXFd6vAdKTu6tweC8K9ApQo6uvq+6monhkcwBZGvYRO6RLaysnKaiLSsB+//jZr9gbR0Otuydd0pR2CBhuCXVZOPAUfifpW4vMdBZQVIb3m89fvam1V8puUHVP6ECHD8AJ+fMgCkXDuTB5BPC6GkLzr59W245j5wywCrqbC50qCw0qbNtUQ9d9xMBhYpPhdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17GU+G3CCSbDY10GppRsgt9nbRMHr7vIwzZMu1vx2rA=;
 b=WYxzLTeYNy7vOQPdpmkIbD5nxWtr/X5secheb6mkJLDT4Zaun5tWdxTT/PwJoHoHAxoe3yWKl9OoNktR6GKidrK9mms2tbTppsFjfMQYkdVCrNCvTP0QvQi2WWeTq6WmyK4zP3003bZRPO36JOCTVWgnGKSXtDLqlpMSdg6Lw35XGKkQHJpO2Z347v3/SfGHpT3spPjh0i38gOCJIqKvoJXf9v/VodmHpBvACM5EmpNkyW3Pif74kqBTSTb4QUPc8MduuZ4PKGmw2bU8h1MbZLGcpFxnAKrjluRdjpNWHPMfvGww5L6gSfWcysytK/UbE8LuCg75mS98zfrQggA07A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17GU+G3CCSbDY10GppRsgt9nbRMHr7vIwzZMu1vx2rA=;
 b=L7xHdTcIV+SXJ2X8HStTUgef9ORTGZqArNKnv+pF4KeSV8utKx0YTxKQ7oxjsjdYejxcSehTQ0Z1weg4GyOZvkU4AKZx6OwAzeEah+lCh8StRI7gqBsgMDp2PAzD2wD1ah5pdhdXflcoR0W1SDHXWq2gI7Ng3uFM+ZLJsOgR6MU=
Received: from BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20)
 by BN9PR12MB5225.namprd12.prod.outlook.com (2603:10b6:408:11e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 14 Jul
 2021 13:29:23 +0000
Received: from BN9PR12MB5145.namprd12.prod.outlook.com
 ([fe80::494e:c22a:4e4d:1dc9]) by BN9PR12MB5145.namprd12.prod.outlook.com
 ([fe80::494e:c22a:4e4d:1dc9%4]) with mapi id 15.20.4331.022; Wed, 14 Jul 2021
 13:29:22 +0000
From: "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>, "Siqueira, Rodrigo"
 <Rodrigo.Siqueira@amd.com>, "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "Chen, 
 Jiansong (Simon)" <Jiansong.Chen@amd.com>
Subject: Re: [PATCH] drm/amd/display: avoid printing ERROR for unknown CEA
 parse(v2)
Thread-Topic: [PATCH] drm/amd/display: avoid printing ERROR for unknown CEA
 parse(v2)
Thread-Index: AQHXeIu9UqDS6vmMhUa4hy3FV9d6aqtCd05g
Date: Wed, 14 Jul 2021 13:29:22 +0000
Message-ID: <BN9PR12MB5145B11D6ABBB6FA1BA28F3EFF139@BN9PR12MB5145.namprd12.prod.outlook.com>
References: <20210714083901.9312-1-guchun.chen@amd.com>
In-Reply-To: <20210714083901.9312-1-guchun.chen@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-14T13:29:22.536Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74b875a4-c4cf-4a45-5e17-08d946cb6499
x-ms-traffictypediagnostic: BN9PR12MB5225:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5225EAB9C4DDDD20F46C386EFF139@BN9PR12MB5225.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dED0K5N4anDLp+5z+FunVR5aQSlAn3z2sVBbJD6kHInEpAzWSuysPzsT4A9vupTI5RCcZSqXXqnzi+XPHFarwp2cZ3+Y8hQTwIdbeiySSQCpmZ2gZuTDU/zl4Jdz2AqaaTkuHUp40H6pHlO16alVyn/u7bC3Tg2uBhKfdS9wy4w34fwtuB/fzRVcKSiH52+LGGw2dCvr5tQHp5VYnBaVYZaghqbXZ4hciMUhVozSSzinSXoUYd2Usydw1KA5g22twsQFwmZxyYTvxPPuhIKmslAEbyRGKsGRvlwz3D/vy2RbNrxAD6hlbs+E/wRF4jpY6YWV7vVdhIyd8DTORWlLrMEldbGwRfvxKqvP1zqw7UKqnxYx6zXbdxaTCJcmdzC+MW2hnJGM9i96o3RhUtOv5cp/p4JN0kILHP3o1pEaetwmxUfXKvAxSS54v8duiSCPZQai/wvIBwsN26tpVXXusioKfJTZJbt6tk2jKdVLW4WCvQL1iV0EfqZsfoH6oKXLPov6UGNQbQT3L+ZeCVC4+LIC+CDrrNeX9kZ/5FbNO3pnf7ptWtsVPvBObSzeH0LAriTvLP95hNHDcqDj3wQc4i8nPNVak1/+r6ViLGRpHb20Xe5tOEBR/XRsufe5a8gQ9rKbBCZQQOoSjK80akSH9SN/PlySNgXNC+am69SFoA05b2gPsassqhYlIN/2xUyoEQlzVvRr4qL4HdPrcSW2mpAqwbdJMHR2KUxT3HzRbs6rIJase00JXNQXqhUd04v1aNOCl3BUlejB59xuA63lrbPg8FhBbYaq8pgOuTDF4b2ZhHhe2AwrECkwL71xlDJrPyQS3r65RKYgijekiIktPwwKvfM7k20f43slv1ocmFQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5145.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(166002)(921005)(8936002)(52536014)(2906002)(66556008)(38100700002)(66476007)(8676002)(66446008)(91956017)(6506007)(64756008)(53546011)(66946007)(76116006)(478600001)(7696005)(6636002)(5660300002)(26005)(122000001)(186003)(55016002)(9686003)(86362001)(19627405001)(316002)(71200400001)(110136005)(33656002)(83380400001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?32CqlU1I5hZ/rN8sdcALclG6He1O9V5NQog3RJXI1awkbGAbVeeQLC78wLgF?=
 =?us-ascii?Q?JEIz0psjTMdf9ryVvEpV8HD6z3PCdxxV3pIioYUWG708eWkbtQqIDTao46Hd?=
 =?us-ascii?Q?u2HQXsbpeKwq4tTOXifq5qGXawHivggohxEVK2WV3l52wr9MXA4oTy98y9MZ?=
 =?us-ascii?Q?cWicBw+fT9IYwv6KwTvuCNM6Y2Sc2htd9+AP+x5OTT46EPrifiT3SK2w1Lwd?=
 =?us-ascii?Q?lR1AtIWuHrwgzn7GYJDHGkFBAf5ZO4z/iFohBrAXDTyZLT1wl2gSx+jbRe14?=
 =?us-ascii?Q?F/g0MMe/Fl2RNBNok8CCoIWvc8nkfg45R5J81I0UxIYe6muTWLRvLPzCUmbV?=
 =?us-ascii?Q?34xWU9vq6/fYvIz2gBODM2XM6O4s5YDkfR3li4S/jhOK4iDBJywMObOh5Thh?=
 =?us-ascii?Q?YnopfjjtLuL9LsXSAax+X7KVlo1fxEe+QL7PxzjAuXRXMVESU+D54XvvEic0?=
 =?us-ascii?Q?VR49iBPbMbUFfsfUEx67uQVkxigb8wXCfj7GJOqGK6AM2hUf9m4ptPCn1nXo?=
 =?us-ascii?Q?QtxkZvt1DBem49bdk2UQVtWn0tYguecUBW8O2CnKSeHiljQ3ddb9hI8Z0v8W?=
 =?us-ascii?Q?JoY7AmNhS/GBu6Vxvm0/VuswsL2azmdC7XGCDCoHQ/4wgjvksDsfs81LaNw5?=
 =?us-ascii?Q?CBYOl7bMXmprWrt2VLu4clEYTDBjlWphwia5BONQgn6Nk9JRoK7OssIgaNXW?=
 =?us-ascii?Q?T6wZTcwyA96UL1q4gC6rjyDdQ/u1ZiBTOfBZD8U3tDZo4taKjv6iTJd9/jSu?=
 =?us-ascii?Q?m0sfeAaT6YQkt5R2YrfOerkYfttKIwnmv4Dw8F7ogh/AL41qJMNOPw7fc7ok?=
 =?us-ascii?Q?qtUedbu8U7yG3qXrRKqZjDcsH4kx+aMS3LhUxEqL4ID5qUgHIQWw6U39SHD6?=
 =?us-ascii?Q?rE7wqyVxOFOibQ/eOVBZ8LlPepypsajUG5gUY2X/8rQmxtOwjOkEdUN6vVm6?=
 =?us-ascii?Q?5v9Rcn4Q4NRtD0wT0xtKGqJImCgPwBH/KURFDCPETy0+59YtpgJof0CfYMZY?=
 =?us-ascii?Q?xB8NzQOnVVkH8w41qp7ebLXt4OLG5sj5+GX4MxnS+A4rdqGLLIQapxFePs9U?=
 =?us-ascii?Q?/EvDQGpL3ZuatLji6AIYpWasokOaAqdReszx9NLaZZFu2EDelmHwVikOtfne?=
 =?us-ascii?Q?SopkSHAx5oqiXOJDmc9rcGBhgD0028kwRhB8gqWiMUicWve9byi9y/knIiW5?=
 =?us-ascii?Q?xjf5NW/lW9KS2y8w2FHXcWiQzw3bzb+bn+TG+fAMRNSYmag3dvaIlSX7X9Vl?=
 =?us-ascii?Q?P/2nd2L+V7hnMqKdMCjw5fO7qFuDYi9V1FhPjjUxl+9Q8dLEdR1B+ymOJz0c?=
 =?us-ascii?Q?uwtWTuZX6pAc3Kc8+geq+Ea6?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5145.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b875a4-c4cf-4a45-5e17-08d946cb6499
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2021 13:29:22.9236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGYgoJjHuBT4LVXrKRx2JDUx0HaG0RHMKdcmkYhB3F6PiaOoLyry+n16YH34FzFPgOoyTRMSaZX7vYLBklzH6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5225
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
Content-Type: multipart/mixed; boundary="===============1279493003=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1279493003==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_BN9PR12MB5145B11D6ABBB6FA1BA28F3EFF139BN9PR12MB5145namp_"

--_000_BN9PR12MB5145B11D6ABBB6FA1BA28F3EFF139BN9PR12MB5145namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Hi Guchun,

This patch looks good to me.


Regards

Stylon Wang

MTS Software Development Eng.  |  AMD
Display Solution Team

O +(886) 2-3789-3667 ext. 23667  C +(886) 921-897-142

---------------------------------------------------------------------------=
-------------------------------------------------------

6F, 3, YuanCyu St (NanKang Software Park) Taipei, Taiwan

Facebook<https://www.facebook.com/AMD> |  Twitter<https://twitter.com/AMD> =
|  amd.com<http://www.amd.com/>



________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: July 14, 2021 4:39 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Wentland=
, Harry <Harry.Wentland@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.=
com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Siqueira, Rodrigo=
 <Rodrigo.Siqueira@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Chen,=
 Jiansong (Simon) <Jiansong.Chen@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amd/display: avoid printing ERROR for unknown CEA pars=
e(v2)

For the unknown CEA parse case on DMUB-enabled ASICs, dmesg will
print an error message like below, this will be captured by
automation tools as it has the word like ERROR during boot up
and treated as a false error, as it does not break bootup process.
So use DRM_WARN printing for this.

[drm:amdgpu_dm_update_freesync_caps [amdgpu]] *ERROR* Unknown EDID CEA pars=
er results

v2: Use DRM_WARN to print such info.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 03db86bfaec8..f7ed4d20d168 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10700,7 +10700,7 @@ static bool dm_edid_parser_send_cea(struct amdgpu_d=
isplay_manager *dm,
                 vsdb->min_refresh_rate_hz =3D output->amd_vsdb.min_frame_r=
ate;
                 vsdb->max_refresh_rate_hz =3D output->amd_vsdb.max_frame_r=
ate;
         } else {
-               DRM_ERROR("Unknown EDID CEA parser results\n");
+               DRM_WARN("Unknown EDID CEA parser results\n");
                 return false;
         }

--
2.17.1


--_000_BN9PR12MB5145B11D6ABBB6FA1BA28F3EFF139BN9PR12MB5145namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
Hi Guchun,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
This patch looks good to me.</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
Regards</div>
<div id=3D"Signature">
<div>
<div></div>
<div></div>
<div></div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top:0px; margin-bottom:0px; margin-top:0; margin-bottom:=
0"></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:11pt; font-family:Calibri,sa=
ns-serif; color:rgb(32,31,30); text-align:start; background-color:rgb(255,2=
55,255)">
<span style=3D"margin:0px; font-size:9pt; font-family:Arial,sans-serif; col=
or:black"><u><b>Stylon Wang</b></u></span></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:11pt; font-family:Calibri,sa=
ns-serif; color:rgb(32,31,30); text-align:start; background-color:rgb(255,2=
55,255)">
<span style=3D"margin:0px; font-size:9pt; font-family:Arial,sans-serif; col=
or:black">MTS Software Development Eng.&nbsp;&nbsp;|<b>&nbsp;&nbsp;AMD</b><=
br>
Display Solution Team</span></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:11pt; font-family:Calibri,sa=
ns-serif; color:rgb(32,31,30); text-align:start; background-color:rgb(255,2=
55,255)">
<span style=3D"margin:0px; font-size:9pt; font-family:Arial,sans-serif; col=
or:black"><b style=3D"color:rgb(32,31,30); font-family:Calibri,sans-serif; =
font-size:14.6667px; background-color:rgb(255,255,255)"><span style=3D"marg=
in:0px; font-size:9pt; font-family:Arial,sans-serif; color:black">O</span><=
/b><span style=3D"margin:0px; font-size:9pt; font-family:Arial,sans-serif; =
color:black; background-color:rgb(255,255,255)">&nbsp;+(886)
 2-3789-3667 ext. 23667&nbsp;&nbsp;<b>C</b>&nbsp;+(886) 921-897-142</span><=
br>
</span></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:11pt; font-family:Calibri,sa=
ns-serif; color:rgb(32,31,30); text-align:start; background-color:rgb(255,2=
55,255)">
<b><span style=3D"margin:0px; font-size:9pt; color:rgb(242,101,34); letter-=
spacing:-1.4pt">-----------------------------------------------------------=
-----------------------------------------------------------------------</sp=
an></b><b><span style=3D"margin:0px; font-size:9pt; color:rgb(242,101,34)">=
</span></b></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:11pt; font-family:Calibri,sa=
ns-serif; color:rgb(32,31,30); text-align:start; background-color:rgb(255,2=
55,255)">
<span style=3D"margin:0px; font-size:9pt; font-family:Arial,sans-serif; col=
or:black"><span tabindex=3D"0" style=3D"margin:0px; padding:1px 0px; border=
-width:0px 0px 1px; border-bottom-style:dashed">6F, 3, YuanCyu St (NanKang =
Software Park) Taipei, Taiwan</span></span></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:11pt; font-family:Calibri,sa=
ns-serif; color:rgb(32,31,30); text-align:start; background-color:rgb(255,2=
55,255)">
<span style=3D"margin:0px; font-size:9pt; font-family:Arial,sans-serif; col=
or:black"><a href=3D"https://www.facebook.com/AMD" target=3D"_blank" rel=3D=
"noopener noreferrer" style=3D"margin:0px"><span style=3D"margin:0px">Faceb=
ook</span></a>&nbsp;|&nbsp;&nbsp;<a href=3D"https://twitter.com/AMD" target=
=3D"_blank" rel=3D"noopener noreferrer" style=3D"margin:0px"><span style=3D=
"margin:0px">Twitter</span></a>&nbsp;|&nbsp;&nbsp;<a href=3D"http://www.amd=
.com/" target=3D"_blank" rel=3D"noopener noreferrer" style=3D"margin:0px"><=
span style=3D"margin:0px">amd.com</span></a></span><span style=3D"margin:0p=
x; font-size:10pt; font-family:Arial,sans-serif; color:black">&nbsp;</span>=
</p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:11pt; font-family:Calibri,sa=
ns-serif; color:rgb(32,31,30); text-align:start; background-color:rgb(255,2=
55,255)">
&nbsp;</p>
<p style=3D"margin-top:0px; margin-bottom:0px; margin-top:0; margin-bottom:=
0"></p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> July 14, 2021 4:39 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Wang, Chao-kai (Stylon=
) &lt;Stylon.Wang@amd.com&gt;; Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas=
@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;;
 Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; Chen, Jiansong (Simon) &lt;=
Jiansong.Chen@amd.com&gt;<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: avoid printing ERROR for unknown C=
EA parse(v2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">For the unknown CEA parse case on DMUB-enabled ASI=
Cs, dmesg will<br>
print an error message like below, this will be captured by<br>
automation tools as it has the word like ERROR during boot up<br>
and treated as a false error, as it does not break bootup process.<br>
So use DRM_WARN printing for this.<br>
<br>
[drm:amdgpu_dm_update_freesync_caps [amdgpu]] *ERROR* Unknown EDID CEA pars=
er results<br>
<br>
v2: Use DRM_WARN to print such info.<br>
<br>
Signed-off-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 03db86bfaec8..f7ed4d20d168 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -10700,7 +10700,7 @@ static bool dm_edid_parser_send_cea(struct amdgpu_d=
isplay_manager *dm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vsdb-&gt;min_refresh_rate_hz =3D output-&gt;amd_vsdb.=
min_frame_rate;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vsdb-&gt;max_refresh_rate_hz =3D output-&gt;amd_vsdb.=
max_frame_rate;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;Unknown EDID CEA parser results\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_WARN(&quot;Unknown EDID CEA parser results\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN9PR12MB5145B11D6ABBB6FA1BA28F3EFF139BN9PR12MB5145namp_--

--===============1279493003==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1279493003==--

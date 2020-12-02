Return-Path: <SRS0=1d7w=FG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DB7C64E7A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 02:09:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A4321D7E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 02:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A4321D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBF1A6E834;
	Wed,  2 Dec 2020 02:09:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10CEF6E834
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Dec 2020 02:09:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8uS6MwHmQOmDTpLQNLx0s5j32LLzAMY3gkvwnt2d2Bjt/2XTiaF29ivQJBp+g2iWpyVzehl1wmnNWM2v68OPoZy7QzynyPYKvjGdlbmBy9+RZnQbpBKZsB+HwouSdL6mAvkRDcBUA4rNfP196NyWyNI6IUGmL5P9jB/4637KOSBKpSSqN1GdJw5rloSC9As+4Cca5keISZ6GnpAsF5KvBk2aM45+P5MjGeB5PJO4dPRKskaH9BLn0B6o8hjUchXyvweC7RULl0d6DmNLiteIq2/eLDYasvN0sykNfvmV7PWNpZE7XQDxOP/pmO/SzQLBgFual9VIRCnM1dTwJktMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCgLNPbA4fvKJ8SPCWXTtG9+uAaTcTGe/Hpjv30+ZLE=;
 b=Nsyb/p+3TiAETyNWFAGGy6j7CT2bfUNvxGm3WWNDhKcJSG0zKGEicRczyZDFobf67+aTtnOw6ug1o0i0NkudLSNorfGOK3J5+qNoiZ33avnbsl98yPaJB4uC2tldXNUViwWUuV7edvxwiWgpJLWnLjKTSSkB3Sbih/u60vEQnickwaa2sHT1RNvF98giRFIEqFRlG/LJD7t978zkslznNJ+ZQjCkO0P6r5pKH76ouRlDDr9UChKBkoLL/bcWo92hcgCHCTWu86dKayD3ISUNTEAfq5+WZKLhmDNGOU4g+ORlerCzkQ728LEx/JA2EOdSBcssjRtro7aBK37p9jSVJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCgLNPbA4fvKJ8SPCWXTtG9+uAaTcTGe/Hpjv30+ZLE=;
 b=U3VISWfJem6AhROis+X28FizF+TyEyF40adBQ1UFAElkMMQrJwavFHt6WQT/bFvWA6MVzngRTWgv9YMYwGn8Vw77sMOBynp/pRtydtOcP+jP0qPhUAHIIqYAVDgcmyFWwi3oxeZnjNdMnc5ELvyMjkTDYk4/yVRqCq7VpmgmQdQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3275.namprd12.prod.outlook.com (2603:10b6:5:185::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.25; Wed, 2 Dec 2020 02:09:16 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3589.030; Wed, 2 Dec 2020
 02:09:16 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu/powerplay/vega10: handle error in getting
 pptable
Thread-Topic: [PATCH 1/5] drm/amdgpu/powerplay/vega10: handle error in getting
 pptable
Thread-Index: AQHWyAmcO+0T18GK1UGBz1hv28j37KnjEB5g
Date: Wed, 2 Dec 2020 02:09:16 +0000
Message-ID: <DM6PR12MB2619F551FC3120EA15A5EDAFE4F30@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201201174413.643254-1-alexander.deucher@amd.com>
In-Reply-To: <20201201174413.643254-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e26ea026-09b4-48d7-8cf3-a9f787f79a21;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-02T02:09:00Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 91b7047e-4678-4c9d-0101-08d896674587
x-ms-traffictypediagnostic: DM6PR12MB3275:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3275566C6AD9617BA4A0AF70E4F30@DM6PR12MB3275.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KiEzw92zlOqKkV+lOgQmxM0rtnuPgNqL6TYnsmVScGQ129dKoE0ud6aNpl30LXmKCZV1jdWkr9O+IzfhyxZSVuwNYeHfaY7NjD9krPpxhrnOoZ+NvtbuFX0z5H1/Zqed+XgaKSjKJ93hiPpr+mMK5v0leHaNIb9caAVuJH5bk2FTQnXkgnJZY2dtrlwmVuDHVHJqOecskmcIdIcHaIwJigaC9uSr+U6ZpWRJCdsmbEyXK16y0V7XLHDlyZLV9CwkXuSngSjefcUVuVGUMLy3gv1O79rtCX//rlubg7xVYdjJttvb+YRxO7vEuzdw/wnkw3TeHaoEyr+cEhXzaa6Eg4MhR5O8Dp4oY5MYBZFyaoQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(39850400004)(396003)(66556008)(66946007)(5660300002)(66476007)(9686003)(966005)(8676002)(8936002)(2906002)(4326008)(83380400001)(6506007)(53546011)(186003)(55016002)(110136005)(64756008)(26005)(76116006)(45080400002)(316002)(478600001)(33656002)(7696005)(52536014)(86362001)(71200400001)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tnWaIYBEbhbpWUlIzHB1EKH5QcZj9vfMdPhll6RkHiq8FgDl+Eism3KBjD6F?=
 =?us-ascii?Q?heH8ypCOd3Dy+IdtJ16IXmNH/lZV2c4CMb+wa/3C6istzX+R7fivu3DkQblq?=
 =?us-ascii?Q?ZM8Vi9hD5aYbtJasWw3OefW1nFxDoENX+s20Kcx78nNQvMUlB6j8vy/gue6v?=
 =?us-ascii?Q?CvJuq/5a+tqwA53Vb4tSfeP9/+8mhweYhru+ESga90W1TpjEcLTwnOvshEfv?=
 =?us-ascii?Q?gsNv6mJk4xS6tZ4pcBfbnO14LrRuf5Tgf2ovOoPU85CLLqR77yEvmBx9WmMP?=
 =?us-ascii?Q?J1PYvdmLWX4xNI12+SEFMq7kB+hNEKfsutP83oAsmpRKPSXGQLWtT74OZKL6?=
 =?us-ascii?Q?anGFlWq1ZDxPqAu46Y4Dk7Jo+bZmgu8/fypPNT7LHLXMb0iROI7Vuz6N4mzM?=
 =?us-ascii?Q?VtjVHidpEz9ZS/G4dwuThfpNmCKb7kXqa7aN1IZhv7aL0yJpMUkYkFYkpYlp?=
 =?us-ascii?Q?0sM7D52ke+QxTdGKxocY1kqMCuj3Jp0AuTANoJYOxBHCH+Bwsxc+t4yaa41f?=
 =?us-ascii?Q?SBZz5y/mRtEfhzn76spHpL/ppef77nabJ5BvVMnMIbicOUgjT6DRyclC+WUN?=
 =?us-ascii?Q?qZAl3X48lIQLP7jL8hxS0Jtv+f80W3AH55PQ8qNu+owyjlzcCQ88mgIr72pF?=
 =?us-ascii?Q?DNicIY6sYsX2lVcI/sImTtm6nLlor6Jl8H7llpSmLznaAChjc+RoAZr5isWh?=
 =?us-ascii?Q?fe7WIBf+OtfBB11FIlB1lrsQVtL9gWhtX07QKpCHTDdwFOl3bFIXMAfz6ffi?=
 =?us-ascii?Q?v1dqeC6XYNJJlJfW7PhHhfqP4G/Dcr/wvBPYQ1x5zWxgLwX4kKwQMpv9rtXB?=
 =?us-ascii?Q?KG+90ZmYh7Y6lq63SkD2ws3FOsdQt2+JNn4KWvrREfnXm1u2rm0j3tpSv+WY?=
 =?us-ascii?Q?NytnfTD0kSm2ZcBpbjBpgkaR3lAa0l4MsxyZUjjaLHhesieel7qOyzvPGB6c?=
 =?us-ascii?Q?BTyPnSIKCu3uYo6UM+mBlhtSocsF3iIG3vXKGtmkPOs=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b7047e-4678-4c9d-0101-08d896674587
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 02:09:16.3771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wOTChQX2DDfyVnSGnD6riQDW1GKn3aFkB1hpMv9aajIOhbmrEB7QdRq2AtQ1ywc9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3275
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, December 2, 2020 1:44 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/5] drm/amdgpu/powerplay/vega10: handle error in getting pptable

Rather than just silently dropping it.  Also fixes a set but unused variable warning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 7eada3098ffc..1b47f94e0331 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -3141,6 +3141,8 @@ static int vega10_get_pp_table_entry(struct pp_hwmgr *hwmgr,

 result = vega10_get_powerplay_table_entry(hwmgr, entry_index, state,
 vega10_get_pp_table_entry_callback_func);
+if (result)
+return result;

 /*
  * This is the earliest time we have all the dependency table
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Ce9c8e4747b3c469a054108d89620be2e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637424414658644669%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=O9VmlrFffcLWVvvmfhk%2FcLPKE0r%2FDmLcUR4VHtDa%2FnA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D78C433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 03:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B328961040
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 03:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B328961040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 680E46E02D;
	Fri,  7 May 2021 03:58:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86C056E02D
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 03:58:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVfueuPVfZ7E0ya67U6ehbN/gFBJoZhJ/s4W0+an6CpqetDHEOcax6p+SNAAsWkvZdJlVkk+p1TwWZ05f1YdwrtXIeVx367qxE5Y6RubFpk3W8y4zbzuIie6FfDWkF158E/f1dA6+TFxhDcmazNJN9nMlw9T+5WD/ICxfxa5kT/ih3GIlnXF5p63TJjGvWFjYFLvG7OcT411lo9uCM73smVXY5rQ01OH6uRWrr0YLp5b6zPfnMtHrJVWYX302hUtbgJnbxuUE59eYcLSW/OuQL9Yb5nttua++P5vzQ/O2/3DevlotmAi3VZJaotmOFFZR6DFGyan+v7NVfThCUV1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubN7BHBOdMZW+GS0p2Ce+Tt5B9lpC/gAj0McVbg2oa0=;
 b=Vm5PNTDu6lQi/DNV7Nw7+bFhymZQboQ+ER0IgxJ6KXiI14WszHF2Pg70/9is9Q/0W9Yw2gvoaNt8gcxEkCidq7/yBIEdw5WxdfmVo6dJJKYB0eG8yku7S6jCnJjR5ZZ7iUi3GikM7B7E++5tZ+1O0gLm+EmDOv+Nvm0RByJjF1Qs+EvT7LSQh2coi2IrZrEv0wtLriCz2VD7QjCsQB9RIkiSrmLJbFstlT3SBzJB/qTQ7GL2wx8JiLLU8EMCN9Zcz6PWlNPFEcMO+I6ptP31xvKEDRCrxsfrV52qeba1GFbIgHVQ8TLznzRFosom+oPHCfmCf4ABYuWCJsa8sPVlbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubN7BHBOdMZW+GS0p2Ce+Tt5B9lpC/gAj0McVbg2oa0=;
 b=mn4VBJ9lU4sRYaCr0rbHER8hW6yAdN/q5n9cwN/GYsf85Sh/2csJQvJyeKaB5D6S7xb/lt0p//Ko/+TtaoltmyiiYz93K28+joDyi3sdyML3QGGv1dz6OYeiIUh4Bt+t4CjGklOYQ9P7uMy6Egn1jE6fAQuWNfUK7m3Zg37Ngi4=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5260.namprd12.prod.outlook.com (2603:10b6:408:101::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Fri, 7 May
 2021 03:58:51 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85%6]) with mapi id 15.20.4108.026; Fri, 7 May 2021
 03:58:51 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update the shader to clear specific SGPRs
Thread-Topic: [PATCH] drm/amdgpu: update the shader to clear specific SGPRs
Thread-Index: AQHXQvMUcHlYZf+vqkuiiReYTxRVkarXZI/A
Date: Fri, 7 May 2021 03:58:51 +0000
Message-ID: <BN9PR12MB53683E5948EB8876782E1DB0FC579@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <20210507034245.22543-1-Dennis.Li@amd.com>
In-Reply-To: <20210507034245.22543-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-07T03:58:49Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=e229d521-ab28-4ac7-9de6-df6ed9dfb347;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e92f64d6-957f-48e3-efdb-08d9110c6d3b
x-ms-traffictypediagnostic: BN9PR12MB5260:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB526025A195C82781B14AF6B5FC579@BN9PR12MB5260.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: awBGG58ZbsXQ5qfDm+i548XdJ11QMeEu2jc0Gv+vPrZyry6JsGYhLkbXIqMVmQjVCCa175sLJBm6dw4jK2jEUwrpPMtRtu6JVc3ehon7yL5AMUU97p4BrMhCoS+JpfvQ1GV7Har/e78Mq5m/qNTwWcgpZek79sU2wHcejQJ8FV8D98l7xFm3fmxb+yAV39EgFivzRawSznVzQLMAFAEX5DP4j2WMtk3AWndGxFFR3sZ8UD1ZY1MjRSNgV9JyL67y08krNgCXOFW81LD/BQmcHd0Xwtd8YSDvcrLYa86W3YwKJOEELjzJU9Y9A+frBrnCdpCAx2aP7ixgSYZunM+cRlwc1yRUlrIpn9e0+zPIPISAzBP18LHB+J05yTSkSVrQVQVjJCg2K3eue6amdMl3kHNAB2pQ/ank7Pwtur90vffxO+GruV8CU6TCy3QpoLNANXlVpfFV59uVgDvCY8crh3l82Py/GRhJTTqdqNpu7/uxILFI/iLA9I7NRDGqWq2dG6AlBbCuuP1nw8DCtMUYSbZneF0bPofIih8I6/qWGx6PMp+EXV2Fg2Tzq3WdEZtROiyfIGlgP7TZJGZ8tCA2xom31wYDJDk5h88RSPxnmh+A+PbmBx9czcS7dmxIeNO8Ktvnh9cKMnxEqr2Yg8Zw6g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(76116006)(186003)(55016002)(6636002)(2906002)(8676002)(6506007)(53546011)(86362001)(66556008)(38100700002)(66476007)(122000001)(4326008)(66446008)(64756008)(66946007)(5660300002)(8936002)(478600001)(52536014)(110136005)(33656002)(26005)(83380400001)(9686003)(316002)(71200400001)(15650500001)(7696005)(17423001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?R0EfDE/mGLsTIk6vmquda7r3W7nQNb3+h7Y/V5b5j+1zUnS8Vhvz9/aBInc8?=
 =?us-ascii?Q?YZQL5U1qC8+W7AEiXF0bCEmAhHmWVmFkQ2SzH3MALyZlD/rDFIIN1AIB0kBV?=
 =?us-ascii?Q?hC++c+HOHWjljBYkC0oR+XRjaqXwYqIzp66bMvhB/tm96FHyhQn/FfXXsQbV?=
 =?us-ascii?Q?wHbyFNAhXBjpWI2bgcJVqDVeCiydvx1HKLKwI3reioKUnRkq3q1s4900+JQr?=
 =?us-ascii?Q?8JOytj3taHxAWqLuF0jcjm8rQtrwU6xqhz6JX89+vdEkOK474E4niZGbmV6K?=
 =?us-ascii?Q?dYSEy6Zvbww7A5KcvRBCVYCB7Vxd8vY3odNWYcBSn+XTXV5ytHIHSRM/86oK?=
 =?us-ascii?Q?BM38ZrS5qJRfYyfiYYKFCtkXAIdHj6dTuE+r+zYsk1W6ipTjOLCBsSAy0PkZ?=
 =?us-ascii?Q?3ujiVUXsp1Z6u93h/Wpw2lbiCA6CPRuIBfMKtleRS6s8tM6LRND1KTaY+yda?=
 =?us-ascii?Q?Zjz/ecZkcB56tU8XU4FpJGpjHPjNcq72TF2j6+OKI9rPv8OlgXvdZWw7IaqC?=
 =?us-ascii?Q?jhLmjrq3z+aPjWEoazYShnekTKO+UnVjAJf+vu1ZK2eIpcFtZ4lUk39noEii?=
 =?us-ascii?Q?EQWxnuHyPsDB2QFgg2lPjo+9hsMyWSz4VCMerJSVgxRtgNf5JE52LT1t5m3I?=
 =?us-ascii?Q?mg+lvmdOtqI3+J5LJVOYQk00/7UAtsNbYIyUyv03AusWviM+WOIwhWQYZvVl?=
 =?us-ascii?Q?4C7bWedL9xBITBZZWikPmONIqUQxCZV1epIrYlwPfbT295nMgjdOvdIWGwyW?=
 =?us-ascii?Q?tcuttAptzihyhAHba0x7dBdWMOv15bXvJUlKYMkNZNYcx/Q7OCOIOeLex8iu?=
 =?us-ascii?Q?Y4rwNwHtEn8oUtVnRfoqJE4JthxVdOmIGtxB9ESO3IzO0I1Jm2X6p7uQmYBj?=
 =?us-ascii?Q?ozuIyOIKDwdiEWk4hFOyUjEwH/+qoPQV+IP0Fs1LyKhL98UN7BIeqTDdjCMr?=
 =?us-ascii?Q?A9SFSf/8csq/xEgOqmdNzsjTdr1E0VOEUg7gaq7bqK4V74AYMrLOZDlttrDU?=
 =?us-ascii?Q?7NUYUaOzDhRGAW+DeswKKzMecCyRMUEIs5yOOU+buJy5KlPxkTGF8uOj5kYn?=
 =?us-ascii?Q?rSoloGa8+rZ5TH7Aq1NQ2h7ZFm2U296Gtsk/iAMowuv2UXnmFmyyFKXzXTS5?=
 =?us-ascii?Q?FzPDhUL4swUOZkOCOSHV9O4vhSpvih3ZbAfRF8/Pvf1gE6X4ktbZckdTiYjD?=
 =?us-ascii?Q?O5e1EZ+soRMZ7bP5xhcA/NjnxTldB4t1jEi/bgD9H4yGqnpLY5uv3cO2Kt70?=
 =?us-ascii?Q?V53jHx4DEf7FeeUPp/P0VzTKK8VNNfQmMPQ0Kpk3BZ5/4yt142JnyusTnQ//?=
 =?us-ascii?Q?gm1DWM+yxkDtE0PrWGm19HjS?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92f64d6-957f-48e3-efdb-08d9110c6d3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 03:58:51.8176 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +CMqiRbeGUqHOc5tzCBv/mgZ2321EhH5ilFm8y1bKq3OsuQCzqmHFJCHdzFHFfDc03drsy0AwGk91ObeYG3ZeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5260
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Friday, May 7, 2021 11:43
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: update the shader to clear specific SGPRs

Add shader codes to explicitly clear specific SGPRs, such as flat_scratch_lo, flat_scratch_hi and so on. And also correct the allocation size of SGPRs in PGM_RSRC1.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 025b1e42e31b..8ad6717e67d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -220,23 +220,24 @@ static const u32 sgpr112_init_compute_shader_aldebaran[] = {
 	0x9209a805, 0x920a8a04, 0x81080908, 0x81080a08, 0x81080308, 0x8e078208,
 	0x81078407, 0xc0410080, 0x00000007, 0xbf8c0000, 0xbf8e003f, 0xc0030200,
 	0x00000000, 0xbf8c0000, 0xbf06ff08, 0xdeadbeaf, 0xbf84fff9, 0x81028102,
-	0xc0410080, 0x00000007, 0xbf8c0000, 0xbefc0080, 0xbe880080, 0xbe890080,
-	0xbe8a0080, 0xbe8b0080, 0xbe8c0080, 0xbe8d0080, 0xbe8e0080, 0xbe8f0080,
-	0xbe900080, 0xbe910080, 0xbe920080, 0xbe930080, 0xbe940080, 0xbe950080,
-	0xbe960080, 0xbe970080, 0xbe980080, 0xbe990080, 0xbe9a0080, 0xbe9b0080,
-	0xbe9c0080, 0xbe9d0080, 0xbe9e0080, 0xbe9f0080, 0xbea00080, 0xbea10080,
-	0xbea20080, 0xbea30080, 0xbea40080, 0xbea50080, 0xbea60080, 0xbea70080,
-	0xbea80080, 0xbea90080, 0xbeaa0080, 0xbeab0080, 0xbeac0080, 0xbead0080,
-	0xbeae0080, 0xbeaf0080, 0xbeb00080, 0xbeb10080, 0xbeb20080, 0xbeb30080,
-	0xbeb40080, 0xbeb50080, 0xbeb60080, 0xbeb70080, 0xbeb80080, 0xbeb90080,
-	0xbeba0080, 0xbebb0080, 0xbebc0080, 0xbebd0080, 0xbebe0080, 0xbebf0080,
-	0xbec00080, 0xbec10080, 0xbec20080, 0xbec30080, 0xbec40080, 0xbec50080,
-	0xbec60080, 0xbec70080, 0xbec80080, 0xbec90080, 0xbeca0080, 0xbecb0080,
-	0xbecc0080, 0xbecd0080, 0xbece0080, 0xbecf0080, 0xbed00080, 0xbed10080,
-	0xbed20080, 0xbed30080, 0xbed40080, 0xbed50080, 0xbed60080, 0xbed70080,
-	0xbed80080, 0xbed90080, 0xbeda0080, 0xbedb0080, 0xbedc0080, 0xbedd0080,
-	0xbede0080, 0xbedf0080, 0xbee00080, 0xbee10080, 0xbee20080, 0xbee30080,
-	0xbee40080, 0xbee50080, 0xbf810000
+	0xc0410080, 0x00000007, 0xbf8c0000, 0xbefc0080, 0xbeea0080, 0xbeeb0080,
+	0xbf00f280, 0xbee60080, 0xbee70080, 0xbee80080, 0xbee90080, 0xbefe0080,
+	0xbeff0080, 0xbe880080, 0xbe890080, 0xbe8a0080, 0xbe8b0080, 0xbe8c0080,
+	0xbe8d0080, 0xbe8e0080, 0xbe8f0080, 0xbe900080, 0xbe910080, 0xbe920080,
+	0xbe930080, 0xbe940080, 0xbe950080, 0xbe960080, 0xbe970080, 0xbe980080,
+	0xbe990080, 0xbe9a0080, 0xbe9b0080, 0xbe9c0080, 0xbe9d0080, 0xbe9e0080,
+	0xbe9f0080, 0xbea00080, 0xbea10080, 0xbea20080, 0xbea30080, 0xbea40080,
+	0xbea50080, 0xbea60080, 0xbea70080, 0xbea80080, 0xbea90080, 0xbeaa0080,
+	0xbeab0080, 0xbeac0080, 0xbead0080, 0xbeae0080, 0xbeaf0080, 0xbeb00080,
+	0xbeb10080, 0xbeb20080, 0xbeb30080, 0xbeb40080, 0xbeb50080, 0xbeb60080,
+	0xbeb70080, 0xbeb80080, 0xbeb90080, 0xbeba0080, 0xbebb0080, 0xbebc0080,
+	0xbebd0080, 0xbebe0080, 0xbebf0080, 0xbec00080, 0xbec10080, 0xbec20080,
+	0xbec30080, 0xbec40080, 0xbec50080, 0xbec60080, 0xbec70080, 0xbec80080,
+	0xbec90080, 0xbeca0080, 0xbecb0080, 0xbecc0080, 0xbecd0080, 0xbece0080,
+	0xbecf0080, 0xbed00080, 0xbed10080, 0xbed20080, 0xbed30080, 0xbed40080,
+	0xbed50080, 0xbed60080, 0xbed70080, 0xbed80080, 0xbed90080, 0xbeda0080,
+	0xbedb0080, 0xbedc0080, 0xbedd0080, 0xbede0080, 0xbedf0080, 0xbee00080,
+	0xbee10080, 0xbee20080, 0xbee30080, 0xbee40080, 0xbee50080, 
+0xbf810000,
 };
 
 const struct soc15_reg_entry sgpr112_init_regs_aldebaran[] = { @@ -244,7 +245,7 @@ const struct soc15_reg_entry sgpr112_init_regs_aldebaran[] = {
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_X), 0x40 },
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 8 },
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },
-	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x2c0 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x340 },
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x6 },
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x0 },
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff }, @@ -262,21 +263,22 @@ static const u32 sgpr96_init_compute_shader_aldebaran[] = {
 	0x9209a805, 0x920a8a04, 0x81080908, 0x81080a08, 0x81080308, 0x8e078208,
 	0x81078407, 0xc0410080, 0x00000007, 0xbf8c0000, 0xbf8e003f, 0xc0030200,
 	0x00000000, 0xbf8c0000, 0xbf06ff08, 0xdeadbeaf, 0xbf84fff9, 0x81028102,
-	0xc0410080, 0x00000007, 0xbf8c0000, 0xbefc0080, 0xbe880080, 0xbe890080,
-	0xbe8a0080, 0xbe8b0080, 0xbe8c0080, 0xbe8d0080, 0xbe8e0080, 0xbe8f0080,
-	0xbe900080, 0xbe910080, 0xbe920080, 0xbe930080, 0xbe940080, 0xbe950080,
-	0xbe960080, 0xbe970080, 0xbe980080, 0xbe990080, 0xbe9a0080, 0xbe9b0080,
-	0xbe9c0080, 0xbe9d0080, 0xbe9e0080, 0xbe9f0080, 0xbea00080, 0xbea10080,
-	0xbea20080, 0xbea30080, 0xbea40080, 0xbea50080, 0xbea60080, 0xbea70080,
-	0xbea80080, 0xbea90080, 0xbeaa0080, 0xbeab0080, 0xbeac0080, 0xbead0080,
-	0xbeae0080, 0xbeaf0080, 0xbeb00080, 0xbeb10080, 0xbeb20080, 0xbeb30080,
-	0xbeb40080, 0xbeb50080, 0xbeb60080, 0xbeb70080, 0xbeb80080, 0xbeb90080,
-	0xbeba0080, 0xbebb0080, 0xbebc0080, 0xbebd0080, 0xbebe0080, 0xbebf0080,
-	0xbec00080, 0xbec10080, 0xbec20080, 0xbec30080, 0xbec40080, 0xbec50080,
-	0xbec60080, 0xbec70080, 0xbec80080, 0xbec90080, 0xbeca0080, 0xbecb0080,
-	0xbecc0080, 0xbecd0080, 0xbece0080, 0xbecf0080, 0xbed00080, 0xbed10080,
-	0xbed20080, 0xbed30080, 0xbed40080, 0xbed50080, 0xbed60080, 0xbed70080,
-	0xbed80080, 0xbed90080, 0xbf810000,
+	0xc0410080, 0x00000007, 0xbf8c0000, 0xbefc0080, 0xbeea0080, 0xbeeb0080,
+	0xbf00f280, 0xbee60080, 0xbee70080, 0xbee80080, 0xbee90080, 0xbefe0080,
+	0xbeff0080, 0xbe880080, 0xbe890080, 0xbe8a0080, 0xbe8b0080, 0xbe8c0080,
+	0xbe8d0080, 0xbe8e0080, 0xbe8f0080, 0xbe900080, 0xbe910080, 0xbe920080,
+	0xbe930080, 0xbe940080, 0xbe950080, 0xbe960080, 0xbe970080, 0xbe980080,
+	0xbe990080, 0xbe9a0080, 0xbe9b0080, 0xbe9c0080, 0xbe9d0080, 0xbe9e0080,
+	0xbe9f0080, 0xbea00080, 0xbea10080, 0xbea20080, 0xbea30080, 0xbea40080,
+	0xbea50080, 0xbea60080, 0xbea70080, 0xbea80080, 0xbea90080, 0xbeaa0080,
+	0xbeab0080, 0xbeac0080, 0xbead0080, 0xbeae0080, 0xbeaf0080, 0xbeb00080,
+	0xbeb10080, 0xbeb20080, 0xbeb30080, 0xbeb40080, 0xbeb50080, 0xbeb60080,
+	0xbeb70080, 0xbeb80080, 0xbeb90080, 0xbeba0080, 0xbebb0080, 0xbebc0080,
+	0xbebd0080, 0xbebe0080, 0xbebf0080, 0xbec00080, 0xbec10080, 0xbec20080,
+	0xbec30080, 0xbec40080, 0xbec50080, 0xbec60080, 0xbec70080, 0xbec80080,
+	0xbec90080, 0xbeca0080, 0xbecb0080, 0xbecc0080, 0xbecd0080, 0xbece0080,
+	0xbecf0080, 0xbed00080, 0xbed10080, 0xbed20080, 0xbed30080, 0xbed40080,
+	0xbed50080, 0xbed60080, 0xbed70080, 0xbed80080, 0xbed90080, 
+0xbf810000,
 };
 
 const struct soc15_reg_entry sgpr96_init_regs_aldebaran[] = { @@ -284,7 +286,7 @@ const struct soc15_reg_entry sgpr96_init_regs_aldebaran[] = {
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_X), 0x40 },
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 0xc },
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },
-	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x240 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x2c0 },
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x6 },
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x0 },
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff }, @@ -305,16 +307,17 @@ const struct soc15_reg_entry sgpr96_init_regs_aldebaran[] = {  static const u32 sgpr64_init_compute_shader_aldebaran[] = {
 	0xb8840904, 0xb8851a04, 0xb8861344, 0xb8831804, 0x9208ff06, 0x00000280,
 	0x9209a805, 0x920a8a04, 0x81080908, 0x81080a08, 0x81080308, 0x8e078208,
-	0x81078407, 0xc0410080, 0x00000007, 0xbf8c0000, 0xbefc0080, 0xbe880080,
-	0xbe890080, 0xbe8a0080, 0xbe8b0080, 0xbe8c0080, 0xbe8d0080, 0xbe8e0080,
-	0xbe8f0080, 0xbe900080, 0xbe910080, 0xbe920080, 0xbe930080, 0xbe940080,
-	0xbe950080, 0xbe960080, 0xbe970080, 0xbe980080, 0xbe990080, 0xbe9a0080,
-	0xbe9b0080, 0xbe9c0080, 0xbe9d0080, 0xbe9e0080, 0xbe9f0080, 0xbea00080,
-	0xbea10080, 0xbea20080, 0xbea30080, 0xbea40080, 0xbea50080, 0xbea60080,
-	0xbea70080, 0xbea80080, 0xbea90080, 0xbeaa0080, 0xbeab0080, 0xbeac0080,
-	0xbead0080, 0xbeae0080, 0xbeaf0080, 0xbeb00080, 0xbeb10080, 0xbeb20080,
-	0xbeb30080, 0xbeb40080, 0xbeb50080, 0xbeb60080, 0xbeb70080, 0xbeb80080,
-	0xbeb90080, 0xbf810000,
+	0x81078407, 0xc0410080, 0x00000007, 0xbf8c0000, 0xbefc0080, 0xbeea0080,
+	0xbeeb0080, 0xbf00f280, 0xbee60080, 0xbee70080, 0xbee80080, 0xbee90080,
+	0xbefe0080, 0xbeff0080, 0xbe880080, 0xbe890080, 0xbe8a0080, 0xbe8b0080,
+	0xbe8c0080, 0xbe8d0080, 0xbe8e0080, 0xbe8f0080, 0xbe900080, 0xbe910080,
+	0xbe920080, 0xbe930080, 0xbe940080, 0xbe950080, 0xbe960080, 0xbe970080,
+	0xbe980080, 0xbe990080, 0xbe9a0080, 0xbe9b0080, 0xbe9c0080, 0xbe9d0080,
+	0xbe9e0080, 0xbe9f0080, 0xbea00080, 0xbea10080, 0xbea20080, 0xbea30080,
+	0xbea40080, 0xbea50080, 0xbea60080, 0xbea70080, 0xbea80080, 0xbea90080,
+	0xbeaa0080, 0xbeab0080, 0xbeac0080, 0xbead0080, 0xbeae0080, 0xbeaf0080,
+	0xbeb00080, 0xbeb10080, 0xbeb20080, 0xbeb30080, 0xbeb40080, 0xbeb50080,
+	0xbeb60080, 0xbeb70080, 0xbeb80080, 0xbeb90080, 0xbf810000,
 };
 
 const struct soc15_reg_entry sgpr64_init_regs_aldebaran[] = {
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

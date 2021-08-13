Return-Path: <SRS0=hpB+=NE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51367C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 08:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1313060240
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 08:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1313060240
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98B7E899E8;
	Fri, 13 Aug 2021 08:57:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B801899E8
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Aug 2021 08:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJOxYvhZDNP8n3n1+KBA8nVSKgMdfznTdj6aMw1/yeJzvukIWiqlT/HCUNgIFYIr1i9OWwnC5Z9+2BN30qzQXmEuYVf3EqzNhKSctrnDAntxJyZPyQsW8HvfXZ+s4RLq9FzZvZBtmJYt99ckauZtawZ/LZwEKzJ65ELXRCKZDGfC1d16UKvFbfCWvbQP42DK/j2Ms1wc8eJE/4KPP5fC9iqRWKaUA5TvRdubt+sWgWMEk4hfmTmgnk1XTt7oT2jj3T/0g6itNsd7p8Mt3hbD6mlGJWtTY6az7LFpbBuF3z6I4wPXY1TPCa4OJnVuYRdL0SPK2pOuK1UJlUWtE9vH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXazxqglE0Ejut0UWUj+gOShsY65lVTVupvOMZoHsng=;
 b=CuTGpAnIxel57l/4PjLD98agkcfj/X2TdvNp4V3PAFfk56bEZZfy6aQrRZcUHUcidTzyUMvcrEw1YWNYWTnYkWPR/7rKyUpKjJOjQltKuDVwz+SGYPktDXK8Td3zx/u+2qO9uvMhiWT5z685N3tDxICgW+LvbW5gPS4WjaVYhy64OEBByqixqG+vg09nti1Lqfui3O4f0vDbeuk72Dqz/LCi0yakzCXeKQxWjKLjxNNE1GAqY7MV4iAU0zSOVCCdRLkVDgbtsT4Q3nYF3NnEIP3oxaKTBPeu++oycIkfNPOh71zUoVZPU0EZrZXIDdN20TQPt1DXpcupMfDTshLOoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXazxqglE0Ejut0UWUj+gOShsY65lVTVupvOMZoHsng=;
 b=n7HxPV890vpltnrGKunDc9lM7LmgxB8iRAExlagR8XQdhKW0Eob48ARXgU3HRdLayzfEIodPlCilJWUZwvxXCWbfhnD7iyTXDaAoPqQOUw6SKegFPGlg3nA/YJ5fXdxsjB/J59oW0a0WDg7xuOlQ1DfpkdH6lkWl1jWBuZhS8cs=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Fri, 13 Aug
 2021 08:57:02 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5dd:148c:8b35:b31b]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5dd:148c:8b35:b31b%3]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 08:57:02 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/pm: change the workload type for some cards
Thread-Topic: [PATCH 2/2] drm/amd/pm: change the workload type for some cards
Thread-Index: AQHXkCAwFi3osMehjkqhS8L+Za83VqtxIflA
Date: Fri, 13 Aug 2021 08:57:02 +0000
Message-ID: <BN9PR12MB5257C41662344F8C8855936FFCFA9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20210813084814.17213-1-kenneth.feng@amd.com>
 <20210813084814.17213-2-kenneth.feng@amd.com>
In-Reply-To: <20210813084814.17213-2-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-13T08:57:00Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=072156ea-ca1e-4b1f-90d7-15d7d1bef512;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d37019fb-7b56-4498-05d1-08d95e385168
x-ms-traffictypediagnostic: BN9PR12MB5306:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB53060E9D652D4FC110693EC3FCFA9@BN9PR12MB5306.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kUnoZqv4/ut6H+pdFeh2k/aj2ohH5MhIIdPbJYCjA0njLUMXaBS+MCOT0CXr/Llyj2Wx9Z04zZmKWUx/TQz2Uy13+5cOY1TjIoI2J0EOB/v1TFRmS1r5AuCGjA3aaLopciJyoNP5B6C+woN0Iaxj2/O3wPs3TWaC0zFW+dOGdRZHT1KYGSie40z+BOgOWirQJuiL4GB1PsYTltI7TcJhTAvxlo9nKOMdOUbAjSzcromR0qiCr51AzEoLA6oLZIU+OaNZJDwpX4WqJzgR1cHgMTjW8flH3QQeFlKmm85et7GAQGBk0MPPuiAzvO9tTZxuMYvgJ6w+GAy437N9ZlHpH1NQGeKxM3s3UM0ckvDnwf50IeP1YFritD9eBOHCsz8wKzWS1L3zGbnH5hzWoFaRFgh7EGU3hztA4PI28BoygsDgTqv5YZ7Ksn6hzqx9ZdWtzCmT4wSUIcn1EFrfdGkYgCAhVS7XVH3qfUsabD4zqxgLo2NtT5Ykqd8DPx2UZEafuh9NrJoTdk6oF6rRg+22o1+oIq0Q23JNts7A0DASrbuSzOjVtrT40A1NSb0OwRArpNYYTA0XzSAo92Th5Ol/YVn5OIZi2SiJxO2A9/IRX+AI2Hv+s8kBcpoiNz56mNcydDa8B58/3zAWQfHU6CjrKDVy9EBmE0eJ1tJy0YNkRFnkiLns6OYRoYuKDUA1y9hKyM9ZuTPBfUshTjSZ3Si+4w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(38070700005)(33656002)(64756008)(8676002)(316002)(7696005)(5660300002)(52536014)(26005)(8936002)(478600001)(66946007)(38100700002)(186003)(66476007)(53546011)(122000001)(71200400001)(66556008)(76116006)(83380400001)(66446008)(2906002)(110136005)(55016002)(86362001)(4326008)(6506007)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x4lEKCWVyey7LlPItl2DeKQpquvmm4hrwL9atgYAkwbq4uU1lu4TnhTXnjkC?=
 =?us-ascii?Q?TaHpjzptB6ZEwCxylSLjFOupHObSscZj57q6dH7DN4UeTUkx0OWhXYoTCcfA?=
 =?us-ascii?Q?S1Sh4BFK0Lp2LP8ElabkwoEgIHx3ncW7Lq52X+oDLwU0Uwgz8SHbl5W9NMVe?=
 =?us-ascii?Q?5Hi4DNtLIAe2ASR0gtgFK+tug7+y4WSTg4cfZDyM9WiCMTwEnQpcvnW2DOwd?=
 =?us-ascii?Q?Lej+JS0fvuYJYDLhVR4Vlaf70FfF3xnxcNABDVSRUZex61XoKFlAsloNhqwV?=
 =?us-ascii?Q?hsEJrh8u2cLVkntMmUtE6DDe39X8uJoso/o/GsSCwEbmVmbd2tHEPDn5jH5v?=
 =?us-ascii?Q?i1NjUwSzx5No7IoE56nx7B6eRQNwabp1TkKRL/liFWrSl9LVv4jtU3h3rW4l?=
 =?us-ascii?Q?/qRzDmaQNberxdyFbE80ZnGLWeRtTZ+1W0h++mLji+Y3cWnzhEEdBYPBHMFx?=
 =?us-ascii?Q?iIMySc394DzmGi/Q7g5nrFbZdcb3NIN5c2ikdqXtAtUwJECdLZNyG78A2vML?=
 =?us-ascii?Q?jBkRFnLwVhhoqds5inU3Y7yvJ/3Lx7/3TrBGdotREu4es3Lkh3rZLD26i5DE?=
 =?us-ascii?Q?ZxYrj8Scb3xsmJYrM2ATMjE0go2B4iDpXFLHDfrJuVOXaj64W2aMErCpqqb1?=
 =?us-ascii?Q?FS/LcLpLiQNPieOqhAbu3JW3sFTmXtIxosNeqTTivqq27SW+Sr3OvzpLFzkJ?=
 =?us-ascii?Q?oOoea1XYdRk7OF7T2kBPKud3JsOjFHoeIryl6WPgQh7VvhH+Hioqtfbh5TNC?=
 =?us-ascii?Q?l6RFj8VPSssUdvO8JSLnoZ5t+GQMW983ERwB/0rpUI6lJwpaf9vvYfo+RNLO?=
 =?us-ascii?Q?sCJFY023a33e5BnEGBNzYtonaGwaZjfqFzndmybk6uEsRCG8DJSRnyV0+BDE?=
 =?us-ascii?Q?r6Rf7AVgOKbjqXjHIzD5mNxkVmMeq31rYEUQzhXd9yy2bIcdZNsszloMP+1R?=
 =?us-ascii?Q?OBWmm52Pg0M4mwuHcBYrT6pJB7KsyKQa56vLLAo7W+DtQngYZiY5JQhTkTXE?=
 =?us-ascii?Q?4Fe+Ulnh88mmr7nnFyjPqslHzZOSdvk4tDMC93M2HSdpaWSNQDnGhfJVCvv4?=
 =?us-ascii?Q?MN0Uj19ltTPaT2U8u7Y/KL1Y1/2SzZ45SHnpO691389t9XvBo2ZjW/teaOMn?=
 =?us-ascii?Q?dsoCn8lKdUatsO2A1CBNFU8qPwkZewkg2MtTZaHuK9pG0Y0ys7+O5X9vvwNB?=
 =?us-ascii?Q?ZswJDe1szfTIrU3PI6YKZdJ5i+xRV3h2nZJuhESc58TBU4IPYfpCoY7PhDCH?=
 =?us-ascii?Q?dMy+eZ8ygu8YVGDcbkTg5v9Y36L8Pv5pkdY6UFAJJEVycisvaCIIrAiXEJnY?=
 =?us-ascii?Q?koMSVThF+4BbRZsK4N3cez3S?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d37019fb-7b56-4498-05d1-08d95e385168
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 08:57:02.5362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wvl7tuKCovZFhTrrcIv7NOo0b0KKwKpt+R6yp6M5JU/tESo/7XoyKzXdTTa3+0NKwsmPdrcKJmySqVuIW30imw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5306
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

[AMD Official Use Only]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>=20
Sent: Friday, August 13, 2021 16:48
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd=
.com>
Subject: [PATCH 2/2] drm/amd/pm: change the workload type for some cards

change the workload type for some cards as it is needed.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index a9bd8265b508..f3cd397cb56b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -5127,6 +5127,13 @@ static int vega10_get_power_profile_mode(struct pp_h=
wmgr *hwmgr, char *buf)
 	return size;
 }
=20
+static bool vega10_get_power_profile_mode_quirks(struct pp_hwmgr=20
+*hwmgr) {
+	struct amdgpu_device *adev =3D hwmgr->adev;
+
+	return (adev->pdev->device =3D=3D 0x6860); }
+
 static int vega10_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *inp=
ut, uint32_t size)  {
 	struct vega10_hwmgr *data =3D hwmgr->backend; @@ -5163,9 +5170,15 @@ stat=
ic int vega10_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, u=
i
 	}
=20
 out:
-	smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_SetWorkloadMask,
+	if (vega10_get_power_profile_mode_quirks(hwmgr))
+		smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_SetWorkloadMask,
 						1 << power_profile_mode,
 						NULL);
+	else
+		smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_SetWorkloadMask,
+						(!power_profile_mode) ? 0 : 1 << (power_profile_mode - 1),
+						NULL);
+
 	hwmgr->power_profile_mode =3D power_profile_mode;
=20
 	return 0;
--
2.17.1

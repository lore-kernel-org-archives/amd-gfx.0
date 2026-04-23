Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688FBFAD401
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 04:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A39DD10E27E;
	Thu, 23 Apr 2026 04:34:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iiAQZ/WF";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013041.outbound.protection.outlook.com
 [40.107.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5463E10E27E
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 04:34:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4PeDuUc7bEuahHK5V8fJcg7UucY6Et+bVOif5d9Os746LQpYmGATD3m2+kfLPUHerDowSyVhMITPCr4eOH3ebAzlUihtUY5EjuQI/H3XYqagfhmTJI9SSEnlU4SlCBu704KEOIIhKVwU+/yFBWycUs0vnYAUsKpgptjVumRShP6xbF4tjv3RdEBWT+7rqssfh+AJGE5ztkEhZIQ2hH/8bGkZmCbpp5nPubGrzTRQAQqb/0kST+iC/ff0Fzfa5wHGtJNlVzEjjS6Gu84XgRqr0xqOmzbxlPk3DCHwLLSkrd24jv+N3KPdcm4X43dJ08WOAxbSpTzdZEJMKAOEfJ/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uq2zPKIcQqEMkxe9g26a/ydgfj3AKzIkgYQv2b09tMs=;
 b=TSeK42K6I0f1FEBl+XCzL/CsI+VuSY3U61ZUXvUVYjhiXO8snnNNYdIt5HOhz1X2IdiBWinu12yLc56hRvpqkXq23OyBLUnha+EdJez4YbVroZiDpBMUfxCQJK2X46yZ0+T5iVJhVsHT0eFKp9d3q7xuHAbDTbXIdG/GYU/bdnX3NPS+ybNUooZ6J5ewjIYtCJt/FF8tACwYjOx9FQkIqB4+5klzMh+W6oVBDTMTuJQh3o45226gybbJ8ReFBc6af61wrieSRb8bbAIWrO1b0Ohh7uBx3MNsRgfbZRedbPeENCHSSiNHuoYzaiQruj9gYU2Vyerd09/9rreBk1RdFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uq2zPKIcQqEMkxe9g26a/ydgfj3AKzIkgYQv2b09tMs=;
 b=iiAQZ/WFyRj0wSffCVZjVsJTi7iEeYOEMeFTZzmj48BX82iH0RjloafPSJx+jYUZ7PArxiHEyBFcI9/j53dr7c+iXW/EseFiHUi6QnifRqt4OgBoabgkXXeUjCi6l7WLXyZ9Oq/VaFJjBXyiAW/Ja+Dci0hvj4Hp8HyGhEdWljU=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DS4PR12MB9633.namprd12.prod.outlook.com (2603:10b6:8:27f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Thu, 23 Apr
 2026 04:34:08 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%4]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 04:34:08 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Russell, Kent" <Kent.Russell@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Only send RMA CPER when threshold is exceeded
Thread-Topic: [PATCH] drm/amdgpu: Only send RMA CPER when threshold is exceeded
Thread-Index: AQHc0l0DFzBLfQ/M5EmRom8HrywCy7XsEBaA
Date: Thu, 23 Apr 2026 04:34:07 +0000
Message-ID: <PH7PR12MB8796000A70711D471F956112B02A2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260422133551.654582-1-kent.russell@amd.com>
In-Reply-To: <20260422133551.654582-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-23T04:34:00.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DS4PR12MB9633:EE_
x-ms-office365-filtering-correlation-id: 53097984-add0-4c28-4db4-08dea0f18f15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: BdoyNAZNCDqvXQ08r4plCCzLS1YyNoII3yQy+SeBrAfh1UpTl+c4d4hXOU007OpozbdTpBDUM1wf9ToA5OcbGbfCcQ86UZJ16BTnAkNPqw1vwomNMSY9ePRAUMlI738PiSrjeVjQZbCaLpUomTFheJkluoCNhQwHDoknEUFaJYtNM9olS6rn8dUgB1gFOq/4ZYk3EZajRuhqwUPRL/g78Cpypw/vDnigBXz8eHbu4OXuy6V7Yi9DAqUxcwGKH5cPv5O9Q2jNWDAlV9xwR/espY/BOcQaUymaYyFNq8oAGfF/tipEWyV6cvQgI+ZaRVQN8OFtvePac999mpWxabpBEQwUoQrbheGqauyuYZqwqUmBdO0ZBkFOSLPeAkC6KdDdCpTi7uXFxZiUtKWRLdS27bIxQ50d9apZYCHZ3ExrREokuJ7tWzDUxqdxalC/DZRTH1ZawcxC8U+RULmTTErIba7Ibu10k7HkMKNrmUi0iuknWodFT45kIzlI5YYNBYLX3hxGuvnkI6YtNFt2GYbWB2q5YhfBPWBDl8p2ek8FvhCQGM7xd2RzWxlWwVQipUpTFaNGzMWzgwdTE1TLEeuOACdKJWcPRbiIjKPv6B2u0nJE14VegqlDVYzFdznw8K124cfms/jt5/r1KEnmltdTxdluZp2V2/0ixBLJN/t2KfTpkGs3SaR+BC6/m/QxtrhwMntz0QA4FnkVeQ8qt2G2bXKn7HUIYEEB70Bn5+jGjbhVJbL1PYHrhoTVASVYsxB57M5y/YDiQdM0/CoqBr/T84ybRgUSCKWzBofMZ7dfBXA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JI8gyIYNIFgDBY4j0V8PtfoKRG5KQ5WJT2ToGUoadezQSM4fe+KRUgH/uKrT?=
 =?us-ascii?Q?InMOXDp/loqO/u8ZjuX4r+Ff14WvQVyGoxSnj3qedc8qQMPE5IOIMeLnOGh1?=
 =?us-ascii?Q?ZlhzDG2qwnOwG5MiMDjAkVfrznTRbiSP2XBadkM0pFNzFedCDROINF8PHL3p?=
 =?us-ascii?Q?sa1YQ/1gOZBRIALLyAM1ElVQHAd8ERpAscRenVOXSPJOI4kjCRIx++g4RX8v?=
 =?us-ascii?Q?8y+y1TKXoA/43gayL0wkGXWCaaojBXk1w+nO1oPDPIdkcDMG3aS1spPpEAHZ?=
 =?us-ascii?Q?ln4jhAyHbS+EKO8NuQR8QIEA0R2NoxdHUIGEBfKpQGNPfWBQnJv6plHo+hoN?=
 =?us-ascii?Q?/dFLiRHDPmGuqUM2B5X0BsrMMyidjDyUVyYQ0ugQXUNKRId3KiH0kOfBzlaB?=
 =?us-ascii?Q?2816kQ3zXFTH5531PmEc9k0tckoN8groOD+0pMBW+HBNVXy8+NYgGU5fzcvu?=
 =?us-ascii?Q?CmaXLIy+QXi0+z0hL4PATjDAk5e7B61CnYxcAk/D2haAQlSSXsGbHqOqGYcv?=
 =?us-ascii?Q?Vc4xOvVlHvC6jQrEaPeLO/cPWW5bfxt4IOFbrqnk4H8IL1/0CO2A47DBlgE4?=
 =?us-ascii?Q?YWYezezzE+X/mXvE4qwVuJ011xufoQhwKYAriM7R2EPLeByKJFmvb1kVyyGJ?=
 =?us-ascii?Q?J/UlZ5BdzesBsaK0Jqz33eXTvaIbRnTLraweN2n68qQdX/PWotucGVIt4Yqp?=
 =?us-ascii?Q?JU5rX1JhtTQDZ4RhKngBuNhu2nvRZIbrNhPDkfCOQJ6mEH9E2T5vAW+Hzla7?=
 =?us-ascii?Q?KlykBmNaMW9ZdJMvMpr13wu/qM6FP7N13W3qVOzci9qALkJgRFsBzE/Jsu77?=
 =?us-ascii?Q?+5nAHea6MD7h3xQtpNXCA0hhoxj5bjvJ78LWknvm3GrjYEIw9dmJkLPRb3f5?=
 =?us-ascii?Q?Q7NfC1xkXBnIJqbFiljX7q0ONDcBrt6RdBcGFSvwHSCUiZ5Q2KMZ5BKdHb1Q?=
 =?us-ascii?Q?qv8QwWzRBRL+IFyAp2NwPxcXjDYVtcXdbUIVNnKKJkCDkzuQPuRAuGCySRti?=
 =?us-ascii?Q?ji5vwsoXuRe8GZGh4z/GKi0rD9TPNqzJZ/FKJ/fk0X+wwfJGRI8MEB0E6YpC?=
 =?us-ascii?Q?t/cK6qrvpYXfMs2SX9aYTBrseLBZsO1ksOwDPsm89ahOZ10Mv6pNLaJNoMQ2?=
 =?us-ascii?Q?yQ9amAuEGvqSNr96kD3gn/MMPKWZlrn51enddo8UNG8KgBtRo1YCYdlaaXUc?=
 =?us-ascii?Q?SjeFqJJX8mYQDLRFrmGCi7BlRrX6xzHE+Yvk7AfvQ7+elLx4qWxmjQSFdCXR?=
 =?us-ascii?Q?+FwR6XFvVt7WKHZgTGbHIoIR3nkB9B1wsYgXBSyIYKZ3cBV9zOyMpETJL1RM?=
 =?us-ascii?Q?fP94ZOSeJeCpAJRb1Fh11uz0hjjRIdZGLqZNXIcZ4Vl09i87f1vqwFsVYguG?=
 =?us-ascii?Q?6oRAEaNLEWpelUnLetAbOOh98sY3SKWBjIazfAUbD95Cd1o+duZAYiTlXjzd?=
 =?us-ascii?Q?Ty9jLh6tXjW7Fbt4yFhbrkDj4OAEWvzrETFIk3tTzqva2G2aef9xC0wcSyzo?=
 =?us-ascii?Q?i/Ev07uaabfTRVonnoHhZL6KTJDKueFoaCdZqknMZRHN6paJ+ZhlAR4YD1fp?=
 =?us-ascii?Q?fA5/QfTcbTT/n9TIAw1IcGpI9dfAkZyCf1WP4EoRwFnPjeQLQ8dWdac1v7+O?=
 =?us-ascii?Q?78GA58IqNDk6TnmpsqsUQ0kh1FoFsEnitDcoY7oV4oqgH8cMV7It7IPZbxmy?=
 =?us-ascii?Q?NEWUsrppniSgelh07cQLU7yYjsE3ybaCPqPWbF8zLD9bqbwb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53097984-add0-4c28-4db4-08dea0f18f15
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 04:34:08.0806 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: soHpccXsbpSKuNIgJ5dfG6uKyKebFHHdviSmLp56y6noVV3bNEgdxWLGpLgEs3Kt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9633
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kent
> Russell
> Sent: Wednesday, April 22, 2026 9:36 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>
> Subject: [PATCH] drm/amdgpu: Only send RMA CPER when threshold is
> exceeded
>
> According to our documentation, the RMA should only occur when the
> threshold has been exceeded, not met.
>
> Fixes: 6c470a9bb431 ("drm/amdgpu: Send applicable RMA CPERs at end of
> RAS init")
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index cdf4909592d2..0c57fe259894 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1950,7 +1950,7 @@ void amdgpu_ras_check_bad_page_status(struct
> amdgpu_device *adev)
>       if (!control || amdgpu_bad_page_threshold =3D=3D 0)
>               return;
>
> -     if (control->ras_num_bad_pages >=3D ras->bad_page_cnt_threshold) {
> +     if (control->ras_num_bad_pages > ras->bad_page_cnt_threshold) {
>               if (amdgpu_dpm_send_rma_reason(adev))
>                       dev_warn(adev->dev, "Unable to send out-of-band
> RMA CPER");
>               else
> --
> 2.43.0


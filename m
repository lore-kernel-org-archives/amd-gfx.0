Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEE1C25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 15:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B795F10EC51;
	Tue, 21 May 2024 15:28:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C7nRzXK5";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F23910E0EF
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 15:28:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1rSQqVu01MjI8Kd3eHtnAKB+8DUe8eaMOty3K8mP9VC5MdFjemMnpmB5P6ihEx5gQzf3hc1cT7aINr4qxJZER8vtRYiWWo/1mktI+35l34CR9Nnuzbv6ZECS5V7ZJHIp0xXEN+xCoqvnwjBATAGE4B5a9/9Dd6IHs/o3ran5kt2SzQi6Dscz1VWh6ksytI5VevFpHvBZ9p9r/6FCXnQmRuO56yK/1a6lXI1o7iJjHs9QELiMyDOBOvlSw2pGrJSvx2PTBKzeuS15xKxhyXnhgGEidgaXkxtOqnQgXFJy+4Qa6cSW/zUSNMyL05yZCmJpHRH+Iq4rDSvKLs7FZKH6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31VmzvkjSpNMt3iGHfhD7n9ZGHxSUVxi8MQhiUJ1Gqg=;
 b=gkNE6GyG1vxcSyC2z7E2MxLSL6nF08BFIhm1zV2SUxIhejsUlIMyOCO0H1FJUnKBDRtF4Ts7LyDDKlBBkqJJGoL4HmfBg79c6qmMc+7xyZuyA6HhQsqw5W+XdwRAfo/59KB8O9/tEBIkQ016i88S8Itt67qcNzDT1QD4zF03lPtma25SCrXx6xApW6ibqUJiBG+ldljiVlAuOpc0NYGQS0C03TxPvRNTxnVnGCcMGgbeYzjxPRb8lQvekBLQ4meAFRoXD+pQ0WOz3BVzNhfOSBZ0y+9zqwhfd3bMwXvBMFPJRERclqVJDhkKRXpGS0Ze2kAcpm4k614foBIy4wYR4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31VmzvkjSpNMt3iGHfhD7n9ZGHxSUVxi8MQhiUJ1Gqg=;
 b=C7nRzXK5jWSZlI7WzYT5wIT8ok9Bh4yI519d7eavkP1NchLQazIr2GOvGAUQB/RjrVj2DpULSvZQvKnX+dbcnbI3Ql7WUXYF6mldHtl0fv0b8pkPEmrTvWuxKvUKqHH0vU4QHg635yyttMwmGuyn31AliTFdgcE/jYK7qCQPmNU=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 15:28:28 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%5]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 15:28:28 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, kernel test robot <lkp@intel.com>
Subject: RE: [PATCH] drm/amdgpu: Add CRC16 selection in config
Thread-Topic: [PATCH] drm/amdgpu: Add CRC16 selection in config
Thread-Index: AQHaq06T7tvk07BNwkCY1byyOJi9hrGhUdiAgAB+gMA=
Date: Tue, 21 May 2024 15:28:28 +0000
Message-ID: <CY8PR12MB709982F945E2BB226416C6B08CEA2@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20240521071430.750167-1-lijo.lazar@amd.com>
 <BN9PR12MB5257A0A1BE171376BB7E66E2FCEA2@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257A0A1BE171376BB7E66E2FCEA2@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2ba40c45-95c7-455e-a75f-29e3725fd0c7;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-21T07:55:05Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|SJ1PR12MB6292:EE_
x-ms-office365-filtering-correlation-id: 28bcd6a2-9167-4fa0-1eee-08dc79aaaa12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?JMX6h8DD8RQF4SN+BUdmYQwUi2XcfM+7RNNst68FS3vPXzeq10Y61fta5h8/?=
 =?us-ascii?Q?6Gz4i8wzpltpOs6jIcsC2B5tb5cnc0WnGxfP7FOabqLQxYTut/Zc9OazS8Z3?=
 =?us-ascii?Q?SnwcGLhQ2u+threD4LwTgCwpUkQ7OYJx3XwKpvOKxMo/HrnBtGeqHcR/v5fV?=
 =?us-ascii?Q?XPjdDnSZvqgfe8tSWAEBZ3571zXtwcMMXp3svBDjC56nUz6h684bEh81Vnrb?=
 =?us-ascii?Q?yNJOFFOJj0lPxpoq85pvqj14kEqKA910Rb3uAATlk9nqS7KmeZcm3IBuDbyP?=
 =?us-ascii?Q?jgC/+c0h1/e1u9uljt7GbCneoqlHmaWlehqiD5yyd8RjCRPPyp7ZAT9E1/WG?=
 =?us-ascii?Q?1boD9x/BUEgQ+8WzJ71pJChlVHDu2fUmKbSO4algjGRXSq2xUJRCWLMt5Q89?=
 =?us-ascii?Q?M8Al+ZQ2DU+0+vlpi5Re77On7PF9Pa1Lf2aDOUK8M6LoFXGdicVSNJ60Nxp6?=
 =?us-ascii?Q?c1CjlYaU7+izYQqhNyzmc+SU042ikYatGljZHVfB+RRrMj/MeiBUAVcQD343?=
 =?us-ascii?Q?fZ75n+8BMIQcj+MUeI7ZvArUwgysWsdh66/tAWbTWXe3zx13qQqBkZdJd2yM?=
 =?us-ascii?Q?fsUboZQJNhHxJF/q/Z2LNU715EalstLo/XRZfcyI3W5fKTubZvsn6pGenzUH?=
 =?us-ascii?Q?SbmQXhiHQ1a5ATCnZxRVs6XBi1YRxYKO4dRPAr4MKmeNcPJ7o9qoYv/7oVIw?=
 =?us-ascii?Q?0gbPxXQP+K4x+ZZNoFZ3vJD4gnqabEXtzg5d12+HaBThZtecMqM82jEzb1Lq?=
 =?us-ascii?Q?uSHuL8cm+vXPlS7SFmRe/0Ejd/nO6tMN2ax6luBukB504nJWp5ySvCGT5/So?=
 =?us-ascii?Q?xN3UNng1qZC6OCZ0N+W6DyzohQl1PY2+UrQNkjFot5wUmSvVAs+5Vjn5e+Ks?=
 =?us-ascii?Q?o8b4Hz0SCdd22x1PGanp8s4PTLIHPU3M0fX2xV5erb41eHmowi55+XtJ1kjT?=
 =?us-ascii?Q?KqoNcuWXNeUCNj1mqlm9VHops82o0y+SVCIHfLINn2YOtdv1WTtXw0QY1ccV?=
 =?us-ascii?Q?z8bB1FnYAGWk1+r9qJLuVMGAJqQgc6/VaY4XVCJnv+toCqTa4B06fAPBuPLI?=
 =?us-ascii?Q?OvTqlORUlUOZEeAdOVG2ukfASpHfIPJX/qVvzYPfi1kdJk8rLQfBU3rV9jPA?=
 =?us-ascii?Q?2pCsVTRraZIeigPLLqyMADnxSM6pQIayjhbhshCFf4x2jnnMW2AREJa7S/d7?=
 =?us-ascii?Q?AWr7UlyHh/oGQOJhjlY9j9eKI68RptRWYDqotqyns8VDG42J3nRrxN/pfAmB?=
 =?us-ascii?Q?TuJUHOKqtNB2e48WZ5mQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BUl86e4XZkRybnfWhsUujieQtAWpYCa5d+e+6OEDr//QBaobRRciMvuq2k+k?=
 =?us-ascii?Q?rFdLtxbLZAVIVxYin+9cYaps2WWOIe+RB3aNKvx7O+1/jHQ1DBlAAdY5Cqmb?=
 =?us-ascii?Q?a4wbVaQLBm/LeKxxium1cyUb7DcIg0iy6vFe4rnKUkHtAgrQfhfL6FRnJGWw?=
 =?us-ascii?Q?8FaouiSmZ4WLI9vkSKYiTEtJbNNaROKUOdsmepz7F3gOoBUbF0weYIzGIUKT?=
 =?us-ascii?Q?dfNpu8QDE+xjivB1PJ1uM1A0OXab7NX9k2FPQWEgEMkSbSOWukrPy1zkblQo?=
 =?us-ascii?Q?hseHIJK1EKMlOBAQMtLWKGNIepEJ3e7DtB6j2mIKtrsdC4jOvcFpUPQ+tV5R?=
 =?us-ascii?Q?DrBTPdA/tPU9EPJkK4egQoNT+XlIDZhybWGEjU5fLUv7qYKGmTxE8aTmkEjf?=
 =?us-ascii?Q?c+IFuUkvNJaPYiJq3cLA3qCAVFiTssZR4f4vkdWxe1W/kh8f7rB/1VFGyjG/?=
 =?us-ascii?Q?WYDGVqyiBfGJe0MvVpZuEYM9pp9y9T/YvYsX8Ctq+3d+j9UrBHbJ3wFc7JfZ?=
 =?us-ascii?Q?bdl1zLHUapAnzKRYcS8QT5SMvQLDmyIvqulA61XEWvG8FIVcZ6VQRA29FDUQ?=
 =?us-ascii?Q?ZYXer0dddZZGPgbt3gruokhEm3tWghBTlMDQ8Rml4/0FlOfImA+q+RJ/dUfO?=
 =?us-ascii?Q?ykAGVwiWoONVUN3I/XcEMHC1sJCZjPbWrflWgmeg+IhwWITYaBlRxUGUWdkE?=
 =?us-ascii?Q?Y5jk7Er1+SEQvvjpceLE5KeNRJDFhVdaZCeMx2DtwfaSgcOTRG3xUdUrfBZ5?=
 =?us-ascii?Q?lKQ0YRuevzeGWMp6Hlt9sMOuIfEs5BnSdUfugKQlYcxq5gG/IED2cCmlSXWF?=
 =?us-ascii?Q?uKOcGH9/c+8vA4ac4DnQ4ZxjBe8ef92U+67x2zxr3Qig+o7VM9QeBaeYRv16?=
 =?us-ascii?Q?r2OTgilpWu6ec+viLL3wVRFE8uYvo3jWPhwclK6DvjKpt4ER/dwd6HGbcnfr?=
 =?us-ascii?Q?4dzR7V3lGDrfBlktFRvxxrmkITrdmelUIrOKQdLu8T7NIqpadnGu1G2/9IFE?=
 =?us-ascii?Q?kAMzkq7eOl6u7W2Fx09xCqLLLGcawBJ4E7QVEbtbDFkGjh5zOnwR7EcyF4o5?=
 =?us-ascii?Q?exj2mrF8YrSYmuOgbHQ4qBg3xlZgwnaJZn+p+BB6CXK4R1wXWlRcOsZRWBOU?=
 =?us-ascii?Q?qm2PeS3yQ/7yXne4yfCcY8WtfcpGl8iDOdiV3YspQ1lpa3zqeW9NN3dMpTNZ?=
 =?us-ascii?Q?pHqg1sQb69O74yY9o6ZJD5nnK2dI0RzG4Oe+Xm20KviqjWfY8NIU61GJr4Ql?=
 =?us-ascii?Q?QqB6kODvWwPJLo4Mt5WDi8Cq09g16STEfeJ6trTWH7BdCF/BhdSGU53fKh5g?=
 =?us-ascii?Q?yK0D22Ru4g6NADIIqOEkTtfEXcZpPmDrV73jh8s6kbYI/IHk+JZW5byoYlYH?=
 =?us-ascii?Q?WD2Be3jj4Zct9SVbWXNlygYIGnHgsPtP+/vZWqB3DCfjezGZtH39bM0jOPjJ?=
 =?us-ascii?Q?11pxWj9nKlqbXFgUtchwlzz3tAGd1SdxNq72MzBCR25zSzYB9omIcLF0i+tW?=
 =?us-ascii?Q?0ysLuH2Fo5E1fqkQWZ0aTDIiYUFlYPmzTfN1PR7S8XQFi6Fa6dow4loidMq+?=
 =?us-ascii?Q?cbKUcop/3DvpB3bEnl0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28bcd6a2-9167-4fa0-1eee-08dc79aaaa12
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 15:28:28.4008 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K2aR8dt9C00gze0SesmfXQ9U9kJdXOFZd6k/x6h/FK5YESNjg6t4n9NMapUSs3Db/jebbjCybiReoGpOmfzv9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292
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

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Tuesday, May 21, 2024 3:55 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>=
; kernel test robot <lkp@intel.com>
Subject: RE: [PATCH] drm/amdgpu: Add CRC16 selection in config

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, May 21, 2024 15:15
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Kasiviswanathan,=
 Harish <Harish.Kasiviswanathan@amd.com>; kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amdgpu: Add CRC16 selection in config

KFD uses crc16 for gpu_id generation.

Fixes: 6dbc6469ab0b ("drm/amdkfd: Ensure gpu_id is unique")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405211405.TidTWIBX-lkp@int=
el.com/

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgp=
u/Kconfig
index 0cd9d2939407..0051fb1b437f 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -17,6 +17,7 @@ config DRM_AMDGPU
        select HWMON
        select I2C
        select I2C_ALGOBIT
+       select CRC16
        select BACKLIGHT_CLASS_DEVICE
        select INTERVAL_TREE
        select DRM_BUDDY
--
2.25.1



Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB04ECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Sep 2022 06:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBA2210E1D5;
	Mon,  5 Sep 2022 06:35:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F0BF10E1D5
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Sep 2022 06:35:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bu2pCPuQ5CgS0k/X0RydexxzPzfzDQZD7kSE1QQd7x7DJN+oyWoSKkwCOgVdzjiDdVB5yXkjJSzN1xPiGw/xLnTWC8Tkjho7DGZHkHNml0ZTpL84hBAOmtWfDdIQsIO92P7pTm3ZDZu/RPNYnVvaEDBQS5pkRWue/kGd/0vHpPYUoJMEdnAyLwZO8NkBh6Hpkk1GeDq3G4iW0XlfKsfnLgUOPsBcJb3btIJt6zeu1vqHLqiK1eS0OdA9GmeOh2bUc/I5W80q8Mru4SZjGoMrjTrg4XhFjOXx3Sq8VF4cpB1Fgxyn56fceKIKxfnXgOV8G+L54oGNbLXDJiFjVU6V/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+4Y+oO5FOKIHliVa/FrcqUjXEcKtSVfu71JdSeUBsg=;
 b=bLozqcQpsh6OX2cvUgI2n0dhOzGXMWiKWLMEbAUZ2q2D8ouyjkfxSHgi7CRPjmNN2q/oeyuD05NyDCx35xxAXnrXIGjsvMn/bV8tV/PX8oMj79zDnuXo/xvoOSCEvgxVztSB1RO30PY3kmJ9WpFLRcZAYbmJEX61veHs8p1TnPBKgIjXVnMVORczZNwYaW5hahWXSgqR6X14856YvWfes5TMtrodZdc5LbtFdM99mjgwUpK11HHOKTQokj99s0vS1HA+ybLon6WX/DyAYbIHKX40PUwTHAUzMNL9RKu6OaUgQrDTDyKDqx+XpOID6pghgILR/qjmrTI0fjA3fRVZIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+4Y+oO5FOKIHliVa/FrcqUjXEcKtSVfu71JdSeUBsg=;
 b=gHV+7o+Cueo7fPgkDS10CuoZxNyR3YUY24ssvECgoswAZrC1MyShwErD34NWrCjFPESjU/YcX8TGFF/cGtmo6OFRw1hHRUjUD5QtXg5onUkP4k478M3aBdNgWU5Dnn5P6PJl8GCjxi9ZNzfJYDxk0Kt4AdBIRH6nBiUBBkZ4utM=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by SJ0PR12MB7084.namprd12.prod.outlook.com (2603:10b6:a03:4ae::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Mon, 5 Sep
 2022 06:35:41 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b554:96ce:4449:5e98]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b554:96ce:4449:5e98%5]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 06:35:41 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2] drm/amdgpu: TA unload messages are not actually sent
 to psp when amdgpu is uninstalled
Thread-Topic: [PATCH V2] drm/amdgpu: TA unload messages are not actually sent
 to psp when amdgpu is uninstalled
Thread-Index: AQHYvd56BORbmt9k+UKMfFTpWQcqQK3QZT4g
Date: Mon, 5 Sep 2022 06:35:41 +0000
Message-ID: <CH2PR12MB4215BC1389204B0F153DFC57FC7F9@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20220901083955.2696208-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220901083955.2696208-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-05T06:35:37Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=544c0094-d1e9-4422-ab4b-96142104b77f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-05T06:35:37Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: bce4688d-c523-4518-bc33-f92ab302e824
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c7b3335-a3a0-4568-f10f-08da8f08da89
x-ms-traffictypediagnostic: SJ0PR12MB7084:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C57xToIhnF62hhcgfeF4lcnTneOvj62kzXBDSc/RLUsSGyfYr8KaTa/KVK/aTJd1TuzUKYXHA5sIFLynG1HbihFTl7ekRnFLei/mqpZSiEDiQMUxDL3STC++nkLwO6t6dSLrQeEutTWWIbOH27szmB1s4XVoSlyoGKvuHOotsb+LstLHmLX/4JqptLuENQxLcbIqcvrLdT7yzV5SwNDFaJlikmzxjtdvayWut1rFQ9W9l0xb/wfGswPAbrrSvsaihA63WKnlVs97cABstbGQV/CMbi/fcAue9Xv5k895ocJO2/JAV9msG24M4aUB3UgoyQRoJ2jDraRC8B+VvEA15OVzU37O5tpHV1l+7njMyBMG8cI2DqQHvpbRvWz7vi82eZgT8vOPOSzTKR9LPPxEzrGsiKcp0wOu8D/XxIB+JKSMSL49SDS/QZC4qzmGG95L5q91cSRuuqtqhM+O0F+p0lMiTUTj0QTfyzAhz9WrwDQtfQy9ETxqrSISwgi4Y0tYN0q1i5lqCMt+goCi07GSinvV9vBKi2zn+SD7w9LSJ0zgLJCdr48wIS/+yeOX4ET9/N3Io8Ax8L1+cUHt0qXG19kuifpYkaoicP/S2VoRN+BizoBug0U0Wt5g9R8GCapAuaQyq9m9xk1l2QdhK3+85aQ6Qt2NI5X1daju9822t1Tj2frgISAHZDyXkZ/ziV3qMGWVzFnv5/uZPieO5Bni2jsDMQqu1ZoNbzqrRa6Xc3NhyT4/ysO4L7P4GV6ukAQuPwvMYzjskRLBPipsZ8Sy1g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(122000001)(38070700005)(55016003)(83380400001)(38100700002)(316002)(66946007)(71200400001)(64756008)(8676002)(66446008)(4326008)(66476007)(66556008)(478600001)(54906003)(6916009)(76116006)(5660300002)(52536014)(41300700001)(15650500001)(33656002)(8936002)(26005)(186003)(7696005)(86362001)(6506007)(2906002)(9686003)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rif5K08h7gbZqtRdHVdkA2EgiIP25ZYPSt20ZfxavsikUIK5k+2OtgZ2YmJ4?=
 =?us-ascii?Q?U9KIwv0P+IeeWM/WlpRRVG2uQj9CfeK19C8M2fdcMJ8pqDfaljps3z5Gek68?=
 =?us-ascii?Q?YWurxXg/Q1Dlvvh39iwDunNyLJdFRJWTW0ySnx5PpcImw3hZvcgmCd89SgKq?=
 =?us-ascii?Q?jU+Keh4JrDaaHVuBAIea+5nrdVuQrdm2U0F/Zq5yv587pjG/ZIzb866walIl?=
 =?us-ascii?Q?djJnNbiluwspquVVAR4yqlNJfgCs2QtKcybDE8kdttM1NQau6/9AvR8wfSsm?=
 =?us-ascii?Q?VcadpeAY44yr9AzY1BMbHvF83rrZ6OWpo3YFkHdFIIgAB1Jl53UEM9nrAtuE?=
 =?us-ascii?Q?9bAz3e8/poP9uFEn6JKX2qfddMPAR69ECeOlhbOyvn7mI3+1XQbdi/Z5pSQq?=
 =?us-ascii?Q?ady8dbEFxhlB7VV4DKjcSl69I9OaRZPtNdn9vvkrV3iNsu+aJYiIWShcsgJZ?=
 =?us-ascii?Q?aJpClng69YQJZb35ujKN+vWSRkyP4Hcj9Yk8lCHnnY7yh1UCLzQPuZL7xS+e?=
 =?us-ascii?Q?qEMAKOsFzdY3s6btQhasUAOOUDjumsIo5V2FbpY1QyPXBqZyVRAamx2dRtx2?=
 =?us-ascii?Q?F2W8H87AA3BQfC9mNTtGzxzf/ed4PuysyyEnZ/VCGjYxa1vHDv4mC/nsouqW?=
 =?us-ascii?Q?4wOZ7kzloyfp0UDtjgBg0KpV75DeqCd7S2P5lUQKrONP35UFSEaoWsdKGV8Q?=
 =?us-ascii?Q?1/1t8UTP1fMoZa8BhLnbzFZUi12d7h9QloxsvE3lbiovzMtByRbBXKw91A/m?=
 =?us-ascii?Q?1OqNHq8A54hJc4ZL9LN6f2o66W1G7qlfbFyOnXiWfv/iCm0Wcmc5pkXE77tG?=
 =?us-ascii?Q?XQAqvXqHqMQc+u6ETMVMCtKhJ9NPSLoSS8boYh0WU+hsQ3ZF/oo3vozC16el?=
 =?us-ascii?Q?OITrzxgppAlXbNM1gahEjN9tdmHnuh0hD5HnX4NorRXssSqObAj+f3Iv8dul?=
 =?us-ascii?Q?swOXy2wZBUrWWlmvzyZ4BCowxpiu6492CmFy9eLsf1k8IDqqPNYxGphZFM5/?=
 =?us-ascii?Q?5gDEom+PU47luEJeeFjM7QjwW7pfQNprevPMn72to/b1dpwSbIqXn8g1+FCC?=
 =?us-ascii?Q?t6PULx1GYict/IMkOnMz1lXK9TVsO4c8dQXBTueirEmPlk3Akh3MWMcbAqOU?=
 =?us-ascii?Q?8JihJ9nVaaFooWfy1JtNX3omEyYn+vHYumqhN1ymNVKlsMAZZOPrtrbVmQlr?=
 =?us-ascii?Q?Dp2ybrWbDmt4ZjmXjZ9iwDuUHZrdpdtTks5hDVWIjrK8xFflZ9kkTu6sfS6F?=
 =?us-ascii?Q?g4TJPDjOnWxU9aPyBMxuglX3kcIKXluJReZ3sulb8aa9A4M7dRUii1z2yZrL?=
 =?us-ascii?Q?J5VqKNYtQSJBhcXxQvtG9JNhftawjbcjfpxyLSv/yTCnpJzxUUXd3PKTD8pJ?=
 =?us-ascii?Q?eOquxUcKo2zsXHjrRns5wJkxSXZtn27Wdv1qipiBCZ0mmJVnnv7+qsiM7cmK?=
 =?us-ascii?Q?ZWJptcoYMp5DV0JbOv0X5bfb98WgOjTTC84zS8n9gk4ES//qSkOQ1ZeInYg2?=
 =?us-ascii?Q?OE7yAU4TvFjHs2CHzVj+Rw5k9PsScyJSKrOrqOFSC6ficdBFVI39PqWCDrDU?=
 =?us-ascii?Q?N1W7Dxgdab6QzhE7oEVNR9TZa8RjGBA25gF4V06c?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7b3335-a3a0-4568-f10f-08da8f08da89
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 06:35:41.4705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hsO7vc0UxBoxw+ngzFEFrdX1tnEK9OA4AXBMwuWdTVcUTP6USaGVtqzOenVu+YCH7IY5iJU3SVokV7OJF15fsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7084
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Ping....


-----------------
Best Regards,
Thomas

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>=20
Sent: Thursday, September 1, 2022 4:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH V2] drm/amdgpu: TA unload messages are not actually sent to=
 psp when amdgpu is uninstalled

V1:
  The psp_cmd_submit_buf function is called by psp_hw_fini to send TA unloa=
d messages to psp to terminate ras, asd and tmr. But when amdgpu is uninsta=
lled, drm_dev_unplug is called earlier than psp_hw_fini in amdgpu_pci_remov=
e, the calling order as follows:
static void amdgpu_pci_remove(struct pci_dev *pdev) {
	drm_dev_unplug
	......
	amdgpu_driver_unload_kms->amdgpu_device_fini_hw->...
		->.hw_fini->psp_hw_fini->...
		->psp_ta_unload->psp_cmd_submit_buf
	......
}
The program will return when calling drm_dev_enter in psp_cmd_submit_buf.

So the call to drm_dev_enter in psp_cmd_submit_buf should be removed, so th=
at the TA unload messages can be sent to the psp when amdgpu is uninstalled=
.

V2:
1. Restore psp_cmd_submit_buf to its original code.
2. Move drm_dev_unplug call after amdgpu_driver_unload_kms in
   amdgpu_pci_remove.
3. Since amdgpu_device_fini_hw is called by amdgpu_driver_unload_kms,
   remove the unplug check to release device mmio resource in
   amdgpu_device_fini_hw before calling drm_dev_unplug.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index afaa1056e039..62b26f0e37b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3969,8 +3969,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev=
)
=20
 	amdgpu_gart_dummy_page_fini(adev);
=20
-	if (drm_dev_is_unplugged(adev_to_drm(adev)))
-		amdgpu_device_unmap_mmio(adev);
+	amdgpu_device_unmap_mmio(adev);
=20
 }
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index de7144b06e93..728a0933ea6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2181,8 +2181,6 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 	struct drm_device *dev =3D pci_get_drvdata(pdev);
 	struct amdgpu_device *adev =3D drm_to_adev(dev);
=20
-	drm_dev_unplug(dev);
-
 	if (adev->pm.rpm_mode !=3D AMDGPU_RUNPM_NONE) {
 		pm_runtime_get_sync(dev->dev);
 		pm_runtime_forbid(dev->dev);
@@ -2190,6 +2188,8 @@ amdgpu_pci_remove(struct pci_dev *pdev)
=20
 	amdgpu_driver_unload_kms(dev);
=20
+	drm_dev_unplug(dev);
+
 	/*
 	 * Flush any in flight DMA operations from device.
 	 * Clear the Bus Master Enable bit and then wait on the PCIe Device
--
2.25.1

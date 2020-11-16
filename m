Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC54C63697
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 08:39:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52EE3208C7
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 08:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XSxgxDSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EE3208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D786D89D86;
	Mon, 16 Nov 2020 08:39:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6011389D7F
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 08:39:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibxbLksGd9ebl+maKsu7U/yeRY4xWlDcea28zjQr9VYQo4dkZ9c5hfRG3+zVUgrF97AIxAXFZcg6Ag4A0A+x93oMKv1G+ISJOPSlDh7f1Ip1RYtYgCI8Y+0JV1hpXSUtxpL0l3jOW02+6UzuFLfzdhfr7PH8q8qGLQxmUQowkas5z4nKS1uuwd2yPT2wo1eT9AyioEVZvVuJYlkFrTnL84QDjCq8fQoyKLIZxO228IbD/qjz6sHR4IO6Ng21FExLGjW4jVdDnL3+iOm1ebb+52id+sQntJR1MZt0cOon6doE4NXplKDorQ8GjeL1Wp/QfUzKIMLYVK9LJy1A/5e1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIqZMG2nY0Oe0avnVshiRyqOrejjIcHiBs1af5mO8ho=;
 b=Px8FEkyX2/gj/FUMIhSh0X7i8q55+aw+WWIQ7Gp3g2YFeJRfUOP4T0FlRy3CttPmt/X3QYLphnZWP6AvgF3mcywjCgqz2CE4TQtZnx2cGxW3tfyR0u2x2n1C7gT/FuzvI4KuO0WqZo/dmnmSbgfTxnnw7OCxGh7MYGe4l+Zh4Kx+5tSQRdjAMCfmuvHL0jcE+zQrpb5TT9TxCKebxWomj/7DLRQVwZfUIdBQeucPSh17D7feu+vBO4TCuPNg3EQuYSmuVY/7Gv5vCi8tvn/IotVijgaaxGeUTIBkJ9cVDh23VtuE5xHVjUgnOehZkZWB5OmsPZ8tZM5J+RXu3Cmn7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIqZMG2nY0Oe0avnVshiRyqOrejjIcHiBs1af5mO8ho=;
 b=XSxgxDSMCipo01S0ckr5d1XK68meJndo+KfsSWpV8Y5FC0JWayZgCRd0GcPkqSjS8qWBlocJlH4VrKPWYyTnxmtSeW82PQVTGx7tveEo/8MoopylOtiyZ+0AKfph+HGKs5k9nVIEbiLYQ7rVXs3/aRiAbrE3cR5YrPMugBXEN+Q=
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 08:39:01 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030%12]) with mapi id 15.20.3564.028; Mon, 16 Nov
 2020 08:39:01 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: change the baco parameter
Thread-Topic: [PATCH] drm/amd/pm: change the baco parameter
Thread-Index: AQHWu/FJSpo+UwRD+EasEDvgHXyg7qnKb8PQ
Date: Mon, 16 Nov 2020 08:39:01 +0000
Message-ID: <MWHPR12MB1854EC8322469875A3D2DEF5EFE30@MWHPR12MB1854.namprd12.prod.outlook.com>
References: <20201116081946.15755-1-kenneth.feng@amd.com>
In-Reply-To: <20201116081946.15755-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-16T08:38:56Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d9028a80-414d-46ec-8fab-0000d8d08c07;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-16T08:38:56Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: e2c5a9ba-da7f-429c-96e7-00000454879d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 37655812-91c3-4316-ff67-08d88a0b115a
x-ms-traffictypediagnostic: MW3PR12MB4572:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR12MB45724E3934800F76EC65F49DEFE30@MW3PR12MB4572.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: epaWT4iJcbEJiBHSC69wZhprhIcAYTcxtcRqMbpx5cgD5X/wpeDK5IioemCccAjeW3p8xOzG6GX6XLdll7XiO2vvcxSdv2sK/xE3sejmZx+aiHeqB4bXl+AWnFdSrznIkq25ad2KhpstBflXqh8BPRQrJBzIvPMVVuzQwClGzMC3hWX6VGuRu2L2B+EI5Bzw/h2bOQiLna9QaCdZSGgCKoCZUiE5xWs2KP9a2dfqSTzRlz4ovwt5nADV9gaj9GzHqpqg45+cDsfs5xd38NI0CTLVAGd7Dd+AGeQ9B+aFumlevc+WMQ76GEv/mwJbyn0XVPDl0NcKJvH56wgXl24doNA0E3T9oFaai4IHP/EuN8M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(26005)(76116006)(66946007)(53546011)(6506007)(186003)(55016002)(86362001)(7696005)(66446008)(66476007)(66556008)(64756008)(45080400002)(316002)(966005)(9686003)(110136005)(33656002)(478600001)(52536014)(5660300002)(83380400001)(71200400001)(4326008)(2906002)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: TV8+989JcXO3dCaQkhXc5zkiDyaGLOC0/qM71qn3YzFexO3L0AiO2ndzyOyaHOxqheVed0jqSYlMgPmIPbfpQaTIKaA6rwc4mAVw+XC3XposYs7GA4MvuZCbXfu7Shygzqra61Hib+829w1HMK3GbnV4l5dZhXTH27YziWuckAKi6Tf7zf7HWuIWyrUcp2LsZnqnnq/0DTnHbehdSrRC1ZGl3Yx+A9BvtnpqaYAlOXxc7ODwElpf55KU3we7qeZy21KWmPtCOlYKqhrxZbCh+O7269/UoP3cKJl40L/cif8s1XI1AZBQBSlHNkgLnVmlJrhvUeJoDUlA5HsF+8702hN8iNPvXoJObX3Kr1hIgOio2kIuHQq11CffOzileEA9/2F7andJ3iLYck2ky/WU5gZSJ/sCVBahwEtW6UfbW/1HUQrc4V9lOC/Y5H3RLVD9emiAwyk8RpWS0sBo7SerJvM3OBTN1xWnCh6eGIaEzHLcnU+29gKAHk2JkthabkpVIl2vi/ZrbSSKlcst0zgMG5T8swz80WTaA+R3wei2oaszyZKKFUeeK5giRl7C7+kn//ZNbLjjYym2g6FjkxqmE0CV00EbrL/RTc1uQq9NwgqoihRQhEhz+hJeEb5wqh9qKjdn9vB46VdvknEZ0qsyhkwZElYn8nUcrSj/jfoBG061G8hitOXy54lnKZKazdpUcYB92OjgZcxhPvaCyyG5zSP0O9aMK0nSFGDu/suP9lzqQCTmg+D0zQwWQm6OtjfvsoPnj30bdjiLsvSDmY8asfuu3T46oa3uMnIgiKC24c33oN1QXdEAa71gVPT0qqQUGYSIwyl5gR5h0HIjih0OxfFvuZguXqteGQmAQFTaM1u7qXz1GRrDnQrxYZAlqRqX+g4aufXlZ/FKMaZxjRV1FA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37655812-91c3-4316-ff67-08d88a0b115a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 08:39:01.2095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wXkBOHGr/nXKZm/at3n2OCiAbRJQmB5xFfGB+ZF4LS5wzB3ZDZ7wcSS7QcJIA2pd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4572
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Likun Gao <Likun.Gao@amd.com>

Regards,
Likun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth Feng
Sent: Monday, November 16, 2020 4:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: change the baco parameter

For some products, baco parameter 1 is dummy and this doesn't trigger the baco entry/exit.
Parameter 0 is valid and these products don't depend on ras for baco sequence.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 24 +++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index b6453ee6f8e6..3e1a3cf44a69 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1495,15 +1495,25 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 	mutex_lock(&smu_baco->mutex);
 
 	if (state == SMU_BACO_STATE_ENTER) {
-		if (!ras || !ras->supported) {
-			data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL);
-			data |= 0x80000000;
-			WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL, data);
-
+		switch (adev->asic_type) {
+		case CHIP_SIENNA_CICHLID:
+		case CHIP_NAVY_FLOUNDER:
+		case CHIP_DIMGREY_CAVEFISH:
 			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 0, NULL);
-		} else {
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 1, NULL);
+			break;
+		default:
+			if (!ras || !ras->supported) {
+				data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL);
+				data |= 0x80000000;
+				WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL, data);
+
+				ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 0, NULL);
+			} else {
+			  ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 1, NULL);
+			}
+			break;
 		}
+
 	} else {
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_ExitBaco, NULL);
 		if (ret)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CLikun.Gao%40amd.com%7C5a17f5b6553444e2c0a808d88a086a49%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637411116049489353%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=P7nHys79eOAym5YKKsLxeR4NpsAgLuyu%2BcLglhcxz%2Bc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

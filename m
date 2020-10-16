Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC86C433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 09:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4153020720
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 09:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yf848223"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4153020720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 921E96E0E8;
	Fri, 16 Oct 2020 09:45:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EA2A6E0E8
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 09:45:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkcLLv/3D17HzjqlFwAy5rqZLG054lXEmS2G0qtgafk8pCur+0oy8BMySyWhQsjdHixw429Dg7DF5FHSWb1JOSZZYxAzOVLuw2PM6kVtpdUyQCHJSl8RbsNx1XMl45aQZ4cEsoyq6Ad+9t9bnbpkbvwfpzL2BmDSggqhQzq/WrP548NGKI5ihPju30P7xVXyWYJV0RJpM/40lDYB7zoeb/Xy0rNy89x+s4YMpJGo9GpYe4kQXk62Ls6o9cSm8uPd1pxY2OyD7/r2qPeDY2i561zSROd6QBqmDw3KBupeeKW84aGOeV3HZiaDiL3JqwG8GPC02/DdldV5+n9EdCCOkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B5VBVxwWh/+Ft87gvP6yU6f9FIEyepYrtbEcz92Kug=;
 b=QFNr+kwHM/bTBg+jjHNXMpGNugYYP/dHWlMjBLa7fYlYO18K5v75jKBsk9aJM2pFKaU+LGigYOJjJvkG3/EG6LRerTk24wIKxhLgJpJXRxWzfRUM+OqbAaOcsWYlWrCnvQsOzu8yuQgAql/y9VbCPRO2sA4MLX/K8uGUaQOKH8gwAuvdbpIbatFfSbLz8fcSMzlAv/h3PmFFgRzjj8KPn9wPBQEGDDDc22tG485EigNI34cmzvYA96FOzvTgDw08tClsFN7YE1dxtFkX7azRPMZTOrG5kvn7A6gYBuMboIgc1kgOhb/CgyfIEMCE02vqS2QSXvnZR8/Y8iSa1JXRJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B5VBVxwWh/+Ft87gvP6yU6f9FIEyepYrtbEcz92Kug=;
 b=yf8482231P0U5tzLCv7pem0AMKqvZTdu6QZNX+HvjDPkP1GcA7pou6QFqZ51/bU5VJMDb5rZYNtM7H8XCS8hn7uuP2sJkOH/TlmzS8q6lYWuzI7BmslCaTzoPGOUrfkuYDv7ZD+PIGVpFjNM3J+eZZqe9RAu+p9vu0O5sHKuAiM=
Received: from DM5PR12MB1657.namprd12.prod.outlook.com (2603:10b6:4:d::21) by
 DM5PR12MB1658.namprd12.prod.outlook.com (2603:10b6:4:5::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.24; Fri, 16 Oct 2020 09:45:19 +0000
Received: from DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::c166:6167:91e7:bdaf]) by DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::c166:6167:91e7:bdaf%6]) with mapi id 15.20.3455.035; Fri, 16 Oct 2020
 09:45:19 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/swsmu: correct wrong feature bit mapping
Thread-Topic: [PATCH] drm/amd/swsmu: correct wrong feature bit mapping
Thread-Index: AQHWo5vF4lXEuo6mkEym6ycMZts086mZ+paQ
Date: Fri, 16 Oct 2020 09:45:19 +0000
Message-ID: <DM5PR12MB1657C8A7FB1983135987B0648E030@DM5PR12MB1657.namprd12.prod.outlook.com>
References: <20201016090703.16600-1-kevin1.wang@amd.com>
In-Reply-To: <20201016090703.16600-1-kevin1.wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-16T09:45:11Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=305d1e19-1541-47f4-a5af-0000610108f6;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-16T09:45:11Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 5a40f73a-92d3-4da3-96ec-0000b8a8d7ef
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ae92410-e273-4385-ec81-08d871b831c9
x-ms-traffictypediagnostic: DM5PR12MB1658:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1658B495E16CF66E852676528E030@DM5PR12MB1658.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:317;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ASlz5X53cMA+w8gTpI6jUVmfJKMMVLd4jVz8YQtEu5aHA+JBB7QwP5GixbdsCTWQ3KkI6tqetwUGAR9CaQQArCrg1FGNU2/ezb5gvaYumIvWKL/zsV8C6yAuXJ6zB1QeRXZA/ytoNfcDoNbGJwC8Y6ayyRFJH2msftV4kWxM35sdQa/lljgJmWSjvgVAksf7CheRWq5p2mkzUZ2Bgr1Tm4awutHDuDwNV3hmtHHQwmkyCyIM6CxHghJpa4sRiJ9FmPTesTS0OUjheCBM7+aHIQdOdwEyBmvJw2Ss02E6FFFuN2w1eUTgCz/OXFIGf2DDjevh+jqKMTFVGcScoPSbbXZVV9gMOEzfqIXFM7DTa6sUEf6ZjGXQdzuZyeAdGvIp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1657.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(33656002)(71200400001)(52536014)(186003)(2906002)(8676002)(5660300002)(316002)(8936002)(66556008)(54906003)(110136005)(4326008)(66946007)(64756008)(83380400001)(478600001)(26005)(7696005)(86362001)(55016002)(76116006)(6506007)(53546011)(9686003)(66446008)(66476007)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 4xkhx8YvAV5QuD4xbGdav9yMlheuxAKhknw5mStskGeEvHgR5bFirAqFOhQoRodkfDGd1OYxN9ZCV9sqO4TeYD5g6N9y3ydVkeG3GzQikyVSSzohwIyuxnTmTHOLrP0zwaCbZFLGsvnR11zWbyQmL6szE1Qjaud31YWybmhq0Vx6MEmTu4n3FHNMkbAKi90peahE8jH/M4+9/zRrig2i3L26LW2Ci7T/4ttqgandXKyZ+IaqXrj/QU8IIV5gDPrTkOSeDLnpUchK3fQgi38d/IwoRZWO+7EF6YWiIWFU6qVohWfZSVhX8temeO4oTwHdkD/hPVTCeOG8rPCm1SNAPRgLnHpDCwO1SDty8juDMt8cUZvKIz6qt2okv3UOg0vqdgRuPnj/D+niy6WG8nXAwG711DEoEThba4jk73C++qhkewkxwibks65NX/I2AEGRRPkBKtyelQg+AxRFYlpNvsMc6z3d/prOtYGSuiKiRvghHLg+1twd3SbjkNXU7PZSAeudRzBDQpoi76R55jl6YL0b4VSe3wV10+zriy49AiFhKkVtn8olK/7ygEErO6hG0RUgDFtcrv5fPFILqfQk9vJwmJMldeZawzoTNe/8NOpNktQW6Cc43NU6A59+tnhodv5p7TitvX/k662YxQD0/A==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae92410-e273-4385-ec81-08d871b831c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2020 09:45:19.4254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fqDwU/rFyN9lIi1j77w+nnKy/3tveVJfhoqNC5dk5QUaCAiJlDo8cbFPMDITygy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1658
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com> 
Sent: Friday, October 16, 2020 5:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amd/swsmu: correct wrong feature bit mapping

1.
when smc feature bit isn't mapped,
the feature state isn't showed on sysfs node of pp_features.
2.
add pp_features table title

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 27 ++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index c30d3338825f..92b2ea4c197b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -431,10 +431,9 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 				   char *buf)
 {
 	uint32_t feature_mask[2] = { 0 };
-	int32_t feature_index = 0;
+	int feature_index = 0;
 	uint32_t count = 0;
-	uint32_t sort_feature[SMU_FEATURE_COUNT];
-	uint64_t hw_feature_count = 0;
+	int8_t sort_feature[SMU_FEATURE_COUNT];
 	size_t size = 0;
 	int ret = 0, i;
 
@@ -447,23 +446,31 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 	size =  sprintf(buf + size, "features high: 0x%08x low: 0x%08x\n",
 			feature_mask[1], feature_mask[0]);
 
+	memset(sort_feature, -1, sizeof(sort_feature));
+
 	for (i = 0; i < SMU_FEATURE_COUNT; i++) {
 		feature_index = smu_cmn_to_asic_specific_index(smu,
 							       CMN2ASIC_MAPPING_FEATURE,
 							       i);
 		if (feature_index < 0)
 			continue;
+
 		sort_feature[feature_index] = i;
-		hw_feature_count++;
 	}
 
-	for (i = 0; i < hw_feature_count; i++) {
+	size += sprintf(buf + size, "%-2s. %-20s  %-3s : %-s\n",
+			"No", "Feature", "Bit", "State");
+
+	for (i = 0; i < SMU_FEATURE_COUNT; i++) {
+		if (sort_feature[i] < 0)
+			continue;
+
 		size += sprintf(buf + size, "%02d. %-20s (%2d) : %s\n",
-			       count++,
-			       smu_get_feature_name(smu, sort_feature[i]),
-			       i,
-			       !!smu_cmn_feature_is_enabled(smu, sort_feature[i]) ?
-			       "enabled" : "disabled");
+				count++,
+				smu_get_feature_name(smu, sort_feature[i]),
+				i,
+				!!smu_cmn_feature_is_enabled(smu, sort_feature[i]) ?
+				"enabled" : "disabled");
 	}
 
 	return size;
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

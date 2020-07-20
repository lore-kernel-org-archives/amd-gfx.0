Return-Path: <SRS0=r3ut=A7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32B9C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2020 06:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 810782080D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2020 06:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1UZwi/pJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810782080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEEF689F4A;
	Mon, 20 Jul 2020 06:07:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 368BC89F4A
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2020 06:07:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0mPxP7wzfTNozqBxE8c1aIJKM2Ar/VnI3Iat4JfLUelIpogivoDWbp9LQHEP+ayuKQ3SoB48Yynzeqxv0IaA8YDJE+4zL/Dolf12f079mKb9xkPa73h1OJaXvZ+73wdNsdx/DKk0Np2xb2oI5qhKx/Mmhxvl+eyUl4aXZX16W6oRHJ26muythGyHRzl7jIiz+fYsDJPN+vDy5TEFDZUF1UMufdGc/zQQvHOSnHFT926yUt/dtCXNHfUqvl+d1YJjI6C4Cz90Ga+5bHIk+tyyiJjK0T9lbDdToCVC+lEgD7HlG1rx68DkieKKTqB71LP0AbrP2myrGY0NpJe1ocM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4APvS9PNwXH9cbbHXS5bO4zf6zc/5xw6UmPD7/PRuiU=;
 b=Pz4YiaEnecOBZiyX1NcvkAL1RHjbPb1YibVmv1XQJOwyyM4a1xxDUx1PynJabXNB4NFIy3eaCyDeooQjODhYXizwEnIXHwRA96EG/anpoYU72lv4UG0PTxoI+50lZIGV+OHqkauYvmHzoOhfZ5v2p1Eil8qVQrWHgD0axVaSWxEsfF0qmVUWfhBIm3PCCBf62IGczBi6PAwxiuUNS8IS+M1u3f/ezqCa3auVyw0BDXh+Gb4BW5iQWr43r7ATuVY53i4wJCOfmUxxozgrtI4EynbDKgEctF4NerWJok2M6pivDAURo534soEAd4SYlhs0HGbI+YHSOrp5ix1ZaUMGzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4APvS9PNwXH9cbbHXS5bO4zf6zc/5xw6UmPD7/PRuiU=;
 b=1UZwi/pJyjkKRtOHGROMzJ6OyfKkFUSayE48RaVpxycrCG1cHXHxOgUJnhgL8l2si3p7hitMb/p0wRABB9Swg2469Y5rxXMAHbl7FL6oDdBIU1+qYTFS/VHVcCw56tnimf3cap4ECncUXxEOiYoQjer9sFlXqB6Wz/rK0tXdIX8=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB3032.namprd12.prod.outlook.com (2603:10b6:a03:dd::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 06:07:46 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::f8df:794c:7431:2440]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::f8df:794c:7431:2440%7]) with mapi id 15.20.3174.030; Mon, 20 Jul 2020
 06:07:46 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add printing after executing page reservation
 to eeprom
Thread-Topic: [PATCH] drm/amdgpu: add printing after executing page
 reservation to eeprom
Thread-Index: AQHWXkQVjuJ4a7/i0Eu+7VVQhIvs3KkP+1PA
Date: Mon, 20 Jul 2020 06:07:46 +0000
Message-ID: <BYAPR12MB2888DAF98B8D151C9D6CB414B07B0@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20200720031536.1822-1-guchun.chen@amd.com>
In-Reply-To: <20200720031536.1822-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a8e1f2c0-244c-45be-b1a3-00006a474c1c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-20T06:06:38Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 359003fe-4c7c-452f-5e85-08d82c733938
x-ms-traffictypediagnostic: BYAPR12MB3032:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3032D2B3B61048F70C575FE9B07B0@BYAPR12MB3032.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jv9VH/fyJNgxJg4/O3wRxyoKtDRd2xYZNaMFJFK0TBntZOXPJ9rackBlMgXDIN4pvmQqbS0jUGLq0w7t1W/g5j9F7h7Ko/v1xAZT5GhbGKoL6tdVrfXCmffc4q171pUFgHZJNLkk2m2tsERoaIFxtqjr6qj6w3uqvrOB/duyqOFVVGxnmySfWUNaijsaumnDCyq8LCGAo6Gfa+N2aVahEKXZbVntpfQhyk4Da7sZkP1hDryuqLzgt2vjkq522HzaaP2Iz4yJrjyQkqjxfwFsdgMEZ0sJdBsm5ISd7P5qvSPJSBVWWX8UI7xgvM1u0YJBYKdarBVkeosfAQM53WRrHHeOaEWGFtNIVhfp04znBnA2edfNSFepYOK2XCf8Dvib
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(316002)(110136005)(6506007)(53546011)(8936002)(86362001)(8676002)(2906002)(186003)(26005)(33656002)(7696005)(71200400001)(5660300002)(52536014)(6636002)(478600001)(55016002)(83380400001)(9686003)(64756008)(66556008)(66476007)(66946007)(76116006)(66446008)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 9D6ZJmWZInd3jzNq0YweqcQWluIsPrAVVQ0kNan6bJFM/By+gVZFovuJ8HPSLWRjFnyGlJmmzBdt5e9p5eH/m9kySFhpQpQ9VfFo0iSmiXvnxc1Ut4XnH2YJJKBkBRXD3NpaOioLzS9N2hzXJhEj8STOJiJ9zmimdPc3GVO/n5Tvlfu1Y3hNhX6a4iMTw9qcI8EJ162QVdSwrYyC8YB1Rlqa6AI9Ylg941xZ3LDUK2oPRsLzqckgLE+1zyhVTKbCpq2XdVQhafM44JR07BM+W7B9oQQqtyIklK7lvVoNS35dxxa0a2VjoH5X/un2E2Ahh4qPGu5i5OLCbOe2Fn00ZwfSaQGFW/grwwoJsFzgr1XHyesm0gH3Gbn+OUq/1HIXY44C/cNygHDs1mZOmtV9aOIXMlNr8IXliyXKQNruRHJ6/x+VQPX82mPhTlULfJ3ficb7BO1sseikchJP9onRHXHjsDNBOKhzHpKt2M0hCeLRZQrlbdDt7Ou0lKnr6Uw5
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359003fe-4c7c-452f-5e85-08d82c733938
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 06:07:46.3713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jfPBcTwtzrjIJmB4XYZJ3jD46+4FRKLLNEYsiIRV9shrsFZM9xteZx66RAWV+r2m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3032
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Monday, July 20, 2020 11:16 AM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: add printing after executing page reservation to eeprom

This will tell users if the faulty page has been written to external eeprom device in dmesg log.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 6f06e1214622..4a82a587de28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1622,7 +1622,7 @@ static int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
 data = con->eh_data;
 save_count = data->count - control->num_recs;
 /* only new entries are saved */
-if (save_count > 0)
+if (save_count > 0) {
 if (amdgpu_ras_eeprom_process_recods(control,
 &data->bps[control->num_recs],
 true,
@@ -1631,6 +1631,9 @@ static int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
 return -EIO;
 }

+dev_info(adev->dev, "Saved %d pages to EEPROM table.\n", save_count);
+}
+
 return 0;
 }

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

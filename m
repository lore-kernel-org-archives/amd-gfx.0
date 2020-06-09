Return-Path: <SRS0=75wA=7W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63ABC433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 03:56:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D552078C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 03:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QWrkLWpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D552078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1064B6E9EA;
	Tue,  9 Jun 2020 03:56:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 639346E9EA
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2020 03:56:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sj6tculgC4Ato+bMjUYNww6YXumaA/tvCJI1C3DtHaeqDxhd+T0ayzEzsMin5CqsFWON2cVNeUIyEXioNY3WjkSBTgtcGmNtSeMyUjcuSS+PA2iDTt+9xDFiYOmgCVN+6jDQ4ynJgGDCcaUVtn92NUsv514gqXouTwaLLmjYMXA2Gko4KRJkh+WYf6Bno/Og+e/7gWBlvgDoV0zA7JwcUK2TrrEcgI6aZ8Nbc1YgA9ZKOLZYIJIPTdznGYcdnod61ejL65Bw5WZl0VD1xsdVWo4j8RLVdqC2INz9W7L/FaWuZ031RJTo1WmhbNYZzEUCF+E9nvDSTBGcuDVA98+FuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5eyzL7HpAZAAZMWN3H2jFND7hXjMfVxySDHANj/BKI=;
 b=CgmIIS1UHcYC0H2zYckmnhXnfWT6ZIXcuHLEk+nlaLR0G8hBGjpj8cz4hReQQRaxv2GpYMNKqcsvpJv96BrDlyluhkJ0r1OXG56TLVIjlbr42ONJct/9WQhbTc67gBao3v/GSvkagdYtR7UdD33yRxn9vAv0ZT6aXo3Uw3jV5vFM86lsrl8/8Sz2koYHpZ6xkoJPSbWDBYbJMoxvXMy63Y9xrzG30GEi4pL+g9EfpOPpacXhcqvuThNfLdFTlfxqQR1ih2qCROyc1FhxBnTdOB7vCA2/kzWrWZPzYDvOU0IUf4X2FklnlpD3ijMCfunjtXoTffFkqP7bi4MG/jeIZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5eyzL7HpAZAAZMWN3H2jFND7hXjMfVxySDHANj/BKI=;
 b=QWrkLWpgQQN88ebq1U8GLFSXJBwQ84Tg/TKrqILPxfRN5q8I2bMkmVMLQ2OdIMQNnLhWi2iDYaSZZf//HzN3+LAGyknlyOGDzORqAiihqGj0PeSBo42sEMhQIkutnBQDb034Ll1nsm1A/aey6tjBRsbvqIFb1aAgoWLW5+j8BPE=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3515.namprd12.prod.outlook.com (2603:10b6:5:15f::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.20; Tue, 9 Jun 2020 03:56:43 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 03:56:43 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, "Russell, Kent"
 <Kent.Russell@amd.com>
Subject: RE: [PATCH] drm/amd/powerplay: Fix buffer overflow in
 arcturus_get_unique_id()
Thread-Topic: [PATCH] drm/amd/powerplay: Fix buffer overflow in
 arcturus_get_unique_id()
Thread-Index: AQHWPZ+z0gsxrgR+VUS0K3yOd17EeKjPp1hQ
Date: Tue, 9 Jun 2020 03:56:42 +0000
Message-ID: <DM6PR12MB26194168100E5F96FF94D066E4820@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200608141823.GD1912173@mwanda>
In-Reply-To: <20200608141823.GD1912173@mwanda>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c5d206dc-c2a7-40fa-a008-0000d8bce577;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-09T03:51:47Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b192461-e601-4244-9ab2-08d80c291f5f
x-ms-traffictypediagnostic: DM6PR12MB3515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB35156E64C085AFB5E265DD91E4820@DM6PR12MB3515.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 042957ACD7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R5EQZcjq7ncWkNOC2Q0kmpiXlxS4sdPKibBHCGk4NjghR+7dec1avcuAbT6MW1h+ztjYrTgekMx1+//j/XJVd64lTDGRGxyZ9BHlw3ihw6TTWtVAk43UtxLJnJDDhsnA60z/YnfVjFnAfVJw6kvro7E1Z9sSa8W8YePm2398GhSh/A52HpKmlcog5OwJkHBttC0F5/lj5w80qaKRARpJe9sKe6VBFs8XpFXBS3HCf6Ah1DBfKNmQtiwmPoLIoFZy2F1hbn5MjGZQ6bKoRyZP/+IaVL6UFzxZQdW7ncOWlQsvNR9JOkc3gMwvZvDXlC5aAPLFsPFDLYrOFjewasMSGg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(8676002)(7696005)(52536014)(54906003)(6636002)(83380400001)(6506007)(5660300002)(33656002)(2906002)(86362001)(110136005)(71200400001)(53546011)(4326008)(9686003)(186003)(316002)(66476007)(8936002)(26005)(66446008)(64756008)(478600001)(66946007)(76116006)(66556008)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ff/iJyq6scSSaR9smrKn/P81LY+qLHQkPYZfxLVrs7qgJ2vcF6jWSoYsChqfhZrsGXP+0vwZWML31vzJkpsQU7ewe5Axjm7jZXLCkZ0XdIV/jkVB13zxy8GC1LESP/BlhbfKZDdKVfF6ciH1E+O2BOHybKUa3hi8/OVQh/8a4hlSHHPvFNIt6JibNsTE8mjebPE4wcH/WKoXyPL3RP9FmdcOMq6xzAeF6dFcrxYggmEsnB5MWSpitwxuiONK1XH5evf0SbWpDwara7h1NZhzoX7R8QkivL9WlpEQBmzI7Y2p+KwOGYLxqQa1284VyD+KNXfGSJ9X+CkydCI9n88+dEcaZAx8gW4G6UPW/SE7q7TwuRt+am3/sn+L0/vIayKavwUA634pBFzWBJJT0QZbEO2EH8SlWaoI4RIUjV/fU7Xu8X0ttic0Viz1x6SoRhbwBxWwfdxRdeKx9htlq4J96pzGYEGe+YYX1C3+X5+3L5coVEDlvlG5QKAX3Wlt2fjd
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b192461-e601-4244-9ab2-08d80c291f5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2020 03:56:43.1767 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yi0DfqGcNu1gRPB1kbmdttcEqEYCTfzLlEnzLY/H5TztUe39coGIN1Mh+t9bmiIL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3515
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
Cc: David Airlie <airlied@linux.ie>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

adev->serial which is used to hold the final serial number may need to be enlarged also.
Since it comes with 16 bytes also.

BR,
Evan
-----Original Message-----
From: Dan Carpenter <dan.carpenter@oracle.com>
Sent: Monday, June 8, 2020 10:18 PM
To: Quan, Evan <Evan.Quan@amd.com>; Russell, Kent <Kent.Russell@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; David Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; amd-gfx@lists.freedesktop.org; kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amd/powerplay: Fix buffer overflow in arcturus_get_unique_id()

The comments say that the "sn" buffer is used to hold a 16-digit HEX string so the buffer needs to be at least 17 characters to hold the NUL terminator.

Fixes: 81a16241114b ("drm/amdgpu: Add unique_id and serial_number for Arcturus v3")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index df7b408319f76..a575cb9d1574c 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2266,7 +2266,7 @@ static void arcturus_get_unique_id(struct smu_context *smu)  {
 struct amdgpu_device *adev = smu->adev;
 uint32_t top32, bottom32, smu_version, size;
-char sn[16];
+char sn[20];
 uint64_t id;

 if (smu_get_smc_version(smu, NULL, &smu_version)) {
--
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

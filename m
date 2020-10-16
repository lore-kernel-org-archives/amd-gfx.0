Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA825C433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 12:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DADC207DE
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 12:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k0lEo8O+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DADC207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A9FD6EDD8;
	Fri, 16 Oct 2020 12:53:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 369126EDD8
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 12:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dioOCcCRB3swK/xS7J5/oQfi2D/CL+e7PqzLHWxiHiRn2K/UqkieRDcRHIwznZrK6BosIgfLm96i4XXcdEgFd9Dq4CxGE742h1ovxrCmg5VcqT4cinlGMb9kmXjM/X3yjy8QEL5+PlBJKCYeoHqe7kW+PopF7nRKcXqIpMVBHfJlqMct2H+0Z+7prNar/qjwFA0C3/tsfedq1sAx/IIZBhhlecvubn9PShP1GPbk9Wjj5elmB5kgpNE+HnApn8XfAErFtDRSHB8vbVrNJTRuYO6cLQSv9txXCEs7/6VfHpT+DpAZ5USY2dQPXm5LTCnsJ9p1jLlg0p+sUgbiV24Nyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71Jwk7Wpb+HLpyNr1w6vF7o0viMwdWaCfX8kwmt1yEk=;
 b=gkilka8cOrkYlrz48FwkhMqc2FdrfGfA1GiL2VZHZ/n/qiHi2mIPetSiCZ3a5ZcGc+L/+OAo47Jwg064sxouBjvxDByEUiAaIrSXTCtC/7yMjwBSqOlu16OYcJ/VpBX+eMXsKn9+SRIhm1nV6YX4gQgRYchRV8uEoKrlaLE1+nOTUZRaTXR5qy5CUlLZenOvuh7Coj1rTUfDidIJam7jrDaaVX3Kv9ZYrQkVw2XbzLCx6JyBxugIsIAYVSBK9vP1Oij8w7GOdUSTTzk8nNmEpnq7j3THL06ZCGR3el9e6eBMQJz2lxxmKWLvjzcHWyXgC5WCPhXFFLwGx+70NeBF+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71Jwk7Wpb+HLpyNr1w6vF7o0viMwdWaCfX8kwmt1yEk=;
 b=k0lEo8O+aqOeX4TCZQ+3Km4FFa0DHJ5qHuMyqoV3BByLMvXgOBYFYsCCuhj9ynAd1I3+r6ICfscfkRG+320ueOc3TCOAbUsxmG0fIEkYVTaoTMVnRTgmdzzX3oWj/nmXRnqe7XE44MroM8KByvQB01TYaztt9nmdw7+wrQK3M0o=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4988.namprd12.prod.outlook.com (2603:10b6:5:16a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.23; Fri, 16 Oct 2020 12:52:58 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3477.021; Fri, 16 Oct 2020
 12:52:58 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: drop navy_flounder hardcode of using soft
 pptable
Thread-Topic: [PATCH] drm/amd/pm: drop navy_flounder hardcode of using soft
 pptable
Thread-Index: AQHWo7sHzxK2QEZp7ESw1ra3W79piamaLvOQ
Date: Fri, 16 Oct 2020 12:52:58 +0000
Message-ID: <DM6PR12MB4075E9C87EC6FFEBB5BF0452FC030@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201016125055.3578-1-Jiansong.Chen@amd.com>
In-Reply-To: <20201016125055.3578-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-16T12:52:54Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=6e171330-bc96-41fb-988a-00001b3cb0be;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-16T12:52:47Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: d3dcc188-4e5c-4396-a161-0000731678ff
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-16T12:52:56Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: c702502e-4705-49d5-b615-0000600d81b6
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f3b73e6d-b7e8-474f-a3b0-08d871d268b3
x-ms-traffictypediagnostic: DM6PR12MB4988:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB498809A053032E13F68352E8FC030@DM6PR12MB4988.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TTDxvc/LxN4+VSeanpOpxJ17zn02kMJrtVIQWHoAL1eZNLzeC1g0JeyIC6aVk0SpGJWH69zQZzwhXAOSWKKK4rXpsDKQdcKrPwlaTsm8djHqN0ZB7znQ4emlS7SdC6Iz8RPzPGRVLHHgc5gbdhtL1l3r4GrLdUdl/GIjkMD0aDWIWFCc2eMXUg6FcHM/dG/by8BJOOZ4BbMbgN4T2pPOzMaheX36uNAOw1zwgfUCvELfYkjr05a88xfFdbVVSsJjI973mOLZvfooL5xTsVr4S/BHV9p1ckNFyN1Wp8N0hlyCjmQJTSfoQt8d3rD3zve5RlhEikMMZdttJQ6NJPH2Mg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(8676002)(6506007)(9686003)(33656002)(186003)(86362001)(316002)(5660300002)(54906003)(55016002)(110136005)(66946007)(26005)(2906002)(4326008)(66446008)(66476007)(66556008)(64756008)(478600001)(8936002)(7696005)(52536014)(53546011)(83380400001)(76116006)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: qW9jCQvpVddzp8QmI/bQwgR8MH720m9em9WvpHX/vNQQjS8Wt03hmVkdB6E8Hkjr9EJ6PizTsEvchxkFS790VOYtre9DLCYJ/pzHExpIH3xcCtMclW2yDV6FAfZ3GsM31cXlGk+JGTNrD4FoN72cKu/GSh7cssmBGEt0FEKkXb8hqzStDn0djJQqv9DYNWm1j0BhyA1psopcoJXcyxU9Z4jLL96T/6gwparU882M0D5LrYTHbeabMzaFN9Ddk+pMBBNU5BR8ZOCHgWsR0bbCFL6f/bP9k+vsagafJLpMfXvE6WkB1SCgMhRsp7WOsHwFhcfE1HiESsCl+JYsDAVEnTzZUICgkL4e0EPeMwpg0/TvKpikuO4QBJPz8bPWVx4kPm/xdm8j1Oubjr8q/pkIXRmsIoUxshKEVG2McBA4CFW2HUvdr2zHcBjGHdH41UbTn4v/VRTFnDg+Eb5Y3JhPJIED+zr9kf0DdlIpYFNxT4ASLt7jmr6FMGQlqq4/MfHiJ7J8rfQdQJMkKciSy9q+k0Y6Ne9KQoLUMeOH9qylFOyKG7fERpSeHNo/Y2EpFV7tEKytdB2Q1izkSUV2SsRg/kh72VZd1LFgZhxRTs0cmVsKqaGnfS2bmELrTVjiVtDIidQurn8eP5XA6JnhOWWegQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b73e6d-b7e8-474f-a3b0-08d871d268b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2020 12:52:58.6006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2MDhzvhIW/gnUdA3LLMxP5mrf7d5R4TNnHl8hLxFYDtVgKPbr4hpeHgOH3LcLkHz1fLBlkeh4H6VW6e9RMeFOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4988
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chen,
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Jiansong Chen <Jiansong.Chen@amd.com> 
Sent: Friday, October 16, 2020 20:51
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amd/pm: drop navy_flounder hardcode of using soft pptable

Drop navy_flounder hardcode of using soft pptable, so that it can use pptable from vbios when available.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I33436b023d03ae77a1b92da5a8062e8466e80110
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index c2a6eb93d93c..fff1d2522463 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -337,7 +337,6 @@ int smu_v11_0_setup_pptable(struct smu_context *smu)
 		version_major = le16_to_cpu(hdr->header.header_version_major);
 		version_minor = le16_to_cpu(hdr->header.header_version_minor);
 		if ((version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) ||
-		    adev->asic_type == CHIP_NAVY_FLOUNDER ||
 		    adev->asic_type == CHIP_DIMGREY_CAVEFISH) {
 			dev_info(adev->dev, "use driver provided pptable %d\n", smu->smu_table.boot_values.pp_table_id);
 			switch (version_minor) {
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=Rnur=AS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CFDC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 01:32:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC0F206E6
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 01:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OkNeGVU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC0F206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3975D89DFE;
	Tue,  7 Jul 2020 01:32:03 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700083.outbound.protection.outlook.com [40.107.70.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D42B089DFE
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2020 01:32:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPD+GQbaeZQ6+sOg2QgD0V6uVr9MvyaLPpIRS5oFntwPucIwwHa7MWypxNBUQ3HsTRfW+wmvEIXSpN8oZlv1mTEHXlp3pPK/6NzWh0IQSeqNi9Z77fojTpi/cIn6qZfPQDgQyEsDrBJgIOMJpRRlgW9BYa4Oq3r/gy5uIZDBewQctwTwGCvR0dxUDB2HgvaVm8Fee56GW6q4QlzkRlPirWY1HwR6hgSIS07wsIFitv/ZOXP7XcK90h+QPbcKKvrp7TxwQfQ+uvddLqzHXCQg75eKZHvEOjf/OvCTejCGBye8MC8He2KaF5UrenjBmTziTu+rUnKqumXwfTDc95h4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWnDCLD5zKvsUJly9ze9RptwiWvwnM539CAL4mG5nw0=;
 b=ZGUxbuTYsWB9lKv1lK1NrpbDwDyWFAYakDOqYzLf7IoIrYeYN1sIFfrIwhn6Gx+7/rU+dBTBNOxsCDjGM9JGFNpdEpJMWZ5v1Tt/b9ousSlWmTcquJtEG2DozCr0yzqqvDZ7etRwZ4pWUDrmCCDzGblvJYK2heA8WYdgO49UQ4orbp+GXoqS8fLuoxhpWr4iR0FbATJTd1gwWrdImhVy5YuXlAUhkE5iJWLF/soJuuCAUdkvHSGxtrhdGQpinF20r6PLHlCXc1gWuvI8PZ016H2uLTJI2WyS3las+TfTwg/gPCsmc1eRDBSXQT1CdUhl+zjzlW1cejYXlqxvGWq9sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWnDCLD5zKvsUJly9ze9RptwiWvwnM539CAL4mG5nw0=;
 b=OkNeGVU2MD3zGVsqtg4Q4rIq4FhDImdkwt33kGw7NELoGTBDC6E2NztGIyBxYP6zHm17vcu14EF0tik8l9/62nY4dS4O+A9sgRTFzPgCFEhV0jLwLngKMM8nO7UhQcztYin6QKJnrICfAtg7gH0Q7vHCI6331sySbODLTlXDthQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1356.namprd12.prod.outlook.com (2603:10b6:3:74::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.27; Tue, 7 Jul 2020 01:31:59 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 01:31:59 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/swSMU: drop pm_enabled check in set mp1 state
Thread-Topic: [PATCH] drm/amdgpu/swSMU: drop pm_enabled check in set mp1 state
Thread-Index: AQHWU8n/WbU9bTXQIEGp7deSNmQ2B6j7U8tA
Date: Tue, 7 Jul 2020 01:31:59 +0000
Message-ID: <DM6PR12MB261991937DD86B08A1C0F277E4660@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200706191629.564683-1-alexander.deucher@amd.com>
In-Reply-To: <20200706191629.564683-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=20f7916c-5f17-438a-8cdb-0000106beb7b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-07T01:26:51Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f897c44-da71-45ee-2032-08d822158b20
x-ms-traffictypediagnostic: DM5PR12MB1356:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1356FA423216A0C67087B05CE4660@DM5PR12MB1356.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /r3nVbGV/Y+J7eJ4NBq7/7mBodc5F8sc8LMPXZ5VhKVAjUDEQlIfloJf2Vp3YK9efu+pajvR5+EHV9zNVeAgneklcbVtFdAo6ie1aLJmxSoGkE1mz2zJslvomWSFY+jWElrdonRoFzVSeeZStbztRxfCUU0Ub2ZR59Ww/qaUIMOwwpgxxHR4HbvsDWnneyy6hyAHp4mDk2nk3dLmzPvWBc5x5L+symn6FjIvMqvI8idlalQIx26b6Ti7sgKroMyEinC0pvwbEedaiMpcfiPO6h6zBtFcgxZCwpp2RqpNuAvVgVHjhg+n1+qcodr8SDNCvjhq11LU8TKjMqEcy5csajCFpjq43jWmXtAIzBP59lw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(52536014)(110136005)(2906002)(316002)(5660300002)(8936002)(186003)(8676002)(71200400001)(55016002)(66946007)(33656002)(26005)(53546011)(66476007)(6506007)(83380400001)(478600001)(4326008)(66556008)(64756008)(66446008)(9686003)(86362001)(45080400002)(966005)(76116006)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: KylGZYXBnd3fXvWU2cxKSN+8m2eVNbFfYzJwkpWgkP4PFeW0p6bT0OjjnoOFe8FeHLhPmodZjsow6WdK9V2MzkpW6EtcnL9Wr6koeQr+h9zchVu6dkLW+jQh9I493o9Exe4Dc3lnmgXMkGZAkpRjXqbnEeey+Cj4YN8ds/WMKm/cVt8PIAPW+6OaH0sO7Ew79K9WrENsyJd3ZkDOXZdl00dCCnYk0sfgxWqmXdeBNeg9YUfn4w2iShLcVj8LzYsjq01aOVe61vOLI1O93rRWWXHXPKQdBQGx7Cu18/KvnOv7QSs5976uRVUGhMDZ144VhZmtiUDBAMZ4GJQDTHRuet2bJLVpWy/dpJKBtt8+7tfquzWKvyw4rEfS9gOhKkWfo59Y/RY2JqSgcx1YSkPMsxKIgmU2LnHvnXzeUyMz1oRXdls69VGKQ2OaHrAqDdt5KoAyQyjK6GnfuNgzaHlfXOIEpuc7O5t5Tru0SBbeUB0=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f897c44-da71-45ee-2032-08d822158b20
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 01:31:59.5321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ouBSY7mej58bXQAnxJ62IZ9b9CtqqMDIyWYO2i8Nqn74NIY29Ms9NZkw7MHKbp8L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1356
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

I think you may wrongly treated the "pm_enabled" as "dpm_enabled".
pm_enabled should be always true unless user specifies "dpm=0" on module loading.

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, July 7, 2020 3:16 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/swSMU: drop pm_enabled check in set mp1 state

We need to set the mp1 state in PCI shutdown and certain reset cases which happens after we've already suspended the SMU.  SMU suspend sets pm_enabled to false which prevents this code from being run.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index fe4948aa662f..0ed75a9897eb 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1924,9 +1924,6 @@ int smu_set_mp1_state(struct smu_context *smu,
 uint16_t msg;
 int ret;

-if (!smu->pm_enabled)
-return -EOPNOTSUPP;
-
 mutex_lock(&smu->mutex);

 switch (mp1_state) {
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C833334723b854666ac1f08d821e11cf8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637296598083021484&amp;sdata=bD1UlSdYqXuPoDoTCvGZHRJr2F6DoJu2LHN6v5p4%2FoA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

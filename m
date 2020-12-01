Return-Path: <SRS0=mtj4=FF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C994BC63777
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 01:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BB5A207FF
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 01:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vHSUw8hH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB5A207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD78D89CE2;
	Tue,  1 Dec 2020 01:59:44 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770050.outbound.protection.outlook.com [40.107.77.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3111F89CE2
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 01:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPsdz3Jazcd3j5wgNUA3zNTdkaBDwswlGD2BlWRcfetD/PQ3whPlm7jf3U0JW/QrVSiXOfBecZMxM0hdfbzc5wu8ee520KNT/U+OADwNcrpNiolKhtSS11Pnd3nB6d/WENquTwyo+26CuDArYdhLohZXXjX0XajNmdhUpqPkw2w6XwrAk+BxHTziU4rI5cqXQCPt0XGsRbHC6Ri5IdM0MiMvCtDsMyHZ9nt2WfUAQpBvbKMr6nuBJvqCosI5lsgwnGGxQjwtE8J0mRdR0YlY+YvbRcElHKWQTqmqzxwK6lUKhfFq/WaHFMrm2706VgrOIFmxU6uAIQDOVFBHuZPYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2l2E+nDZM1bYdkUg0sEovznxqL2HoyKPk4w1TgTeflA=;
 b=NEx4PzrJQf+k9COOy31GHyaqhHQYi4ryYt1blYbn6XIAyu0noz/kutaKuvBePB+Vk1mR8z9fuK9Bs4eIish3+hhbwje3FbAqp7mPwaqmq6/Vzy69cvWCPMj/M2i3NrDs7UQTyZv+6Vq9B/yIoGvCxW2tC5itXgL3VLLIQDdCWTiY6EJ8oSeUOTnLrFLfj5/+WmP47x/rdeIawqaXVm3gGNHpk/DE8xj08JxWjehHw6jULSVyMzsj1g/jOBtYGLVeg5S2UsmFbLzt04xZeYkExrIDYuYWNulFdT3SWYAEFRhFJGA3I63YTSn4Kqi/S5pR4BCF+B6vmfwOwYFbyP/h6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2l2E+nDZM1bYdkUg0sEovznxqL2HoyKPk4w1TgTeflA=;
 b=vHSUw8hHViuywX3/xAds/wbu401mv8JaU6kd948hEqj79S9dFsSr4yqtcOwPqCe8LQOzaVu0eHv2nV5AHRxG55NcYo4qWWhbkf4c8/tlqNAz3vwX2Al0dsS738j0dGsx1eWyd5UVpEo0r0BlrVNf/PW2MwRzupCVaRtQik+Lb2E=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3867.namprd12.prod.outlook.com (2603:10b6:5:1cf::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20; Tue, 1 Dec 2020 01:59:40 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3589.030; Tue, 1 Dec 2020
 01:59:40 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/powerplay/ci: return an error of copying to
 smc fails
Thread-Topic: [PATCH] drm/amdgpu/powerplay/ci: return an error of copying to
 smc fails
Thread-Index: AQHWx25qRw4QIvDQkU613WM3LamG6KnhfFtQ
Date: Tue, 1 Dec 2020 01:59:40 +0000
Message-ID: <DM6PR12MB261973EF0BCD4504CD1AE813E4F40@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201130231317.237210-1-alexander.deucher@amd.com>
In-Reply-To: <20201130231317.237210-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=33971199-b798-4000-866e-47becdb2de92;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-01T01:59:32Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92ef4ca4-fc66-4f46-c8eb-08d8959cc3d7
x-ms-traffictypediagnostic: DM6PR12MB3867:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3867F9F2A23B4FDA88996F7BE4F40@DM6PR12MB3867.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:428;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hML/bQDEhpeh3eefa5BxPsWZ4yO0W4EXgVvQPzsCrQCQeEoOtrjDI+g2xSxohnFfLNol+NSlGusEMdYzMA/8v1uC9NGOTXhbRRrGEiVln5GYYQk82vn4czGluCDUvITMgN00VcV3RKdaPgnBGRm64TtPFuGp1xr9azLazmUtuNQvqBN9CuZ8otBkC0D48hRinGYSeQYUuyGJtQj1FmQPaleR0ulgMehMfmwRDGz0C/2OnnMsruuqrMO4bfgnoPN3+/axBTqrnLdjFF+LgEXQJ3ZtpdlxJGVNd71iKlt9JtSEAwZlW83LGsuQgn/xSBlRirW0T7FIQZHC5z7hdAJYUAAXe3ylYC1bmpLPlZxb5J0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(4326008)(33656002)(316002)(86362001)(8676002)(66556008)(55016002)(66946007)(5660300002)(66476007)(64756008)(186003)(76116006)(26005)(66446008)(52536014)(966005)(53546011)(2906002)(8936002)(71200400001)(7696005)(45080400002)(6506007)(478600001)(110136005)(83380400001)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?WYtCVwsfot9g4ixLnriupSc24hP64TxYfqmTuvCc62lTi2q8P/Ch27/DBGna?=
 =?us-ascii?Q?QeAAXu2ew66jNY9bGZ8MOmMQiFBKOo7JWztMgvP61RFsu57R+SgWRnpyXXnA?=
 =?us-ascii?Q?8Beo2YVCqf8rxd4xaO/cLvWfNGJrH1h3BAp5QaWK8mZ643AfGHbgbpUBPEY2?=
 =?us-ascii?Q?4PXGc3u/0U7IBLDbHJszhmtSudYz6FsRoh+m/AEQX1NX55174aO2YlAx79H2?=
 =?us-ascii?Q?ARjWn5hqP93gGhUqBUEfStFZax4W1euHb/UhDkRVdRATRmVQYzyOEOyoVAbH?=
 =?us-ascii?Q?ZRkuGLsZz4ZhqII14YzSzcccAqELB4Ou2tWCH1zNdk4tL6Fpmc1e/GkUQ8UE?=
 =?us-ascii?Q?ksAVDI6qsxWZiR5+7rao+Nck3Mw30vujwe8UybYW5X8QIJIw9GVFURfkgse4?=
 =?us-ascii?Q?cmzK1E95UQj6/4rCUC3Socp9GioYPFWRACYnv0RY9KvFthiY8d+ck5c1bSCK?=
 =?us-ascii?Q?HYAm+GfGvlMGVbtQ/OpbGodJ1IKwqjLzCshdtMIZSSfQYT5emqE85YKDywSh?=
 =?us-ascii?Q?KK7woddnIZWHePI5DS1wYUIyNEUUfkSMoIwe69ElMb7eSyBl7T4eBG4YFl1J?=
 =?us-ascii?Q?ECVEP0R7i8PJ2d2snzqZEiEJIxIJwO/JrOBQvs6mHGYwJHvolrrHclGUYusb?=
 =?us-ascii?Q?y/WtyyXnTg/yXIKt7MdJTYzcFFAkk3KEWEVXS6BBB6t+zPAbqJrIfs+crd2Y?=
 =?us-ascii?Q?whQvxituW5TbjyyORr6m1ID+TEZB8LlAZgScuWyalHXLc4urbGzE+MPbZ+vr?=
 =?us-ascii?Q?TLjayFeojYUhLMgcjXjGzvKawpvMjwo6yjsOGAjmxBEkd/qUSQZ0yuPEP2tq?=
 =?us-ascii?Q?ilbCSr9ixmEMSsXVdUxqBmi3vrbX5irWYgWUHwB1+5oTbSk1nhW23TIA5Okg?=
 =?us-ascii?Q?/Wi4PtWevUVTUgfYs0VbZYuQoKCTugsXsv7evGo6DX6+cwxcaPSDScKdvQ0y?=
 =?us-ascii?Q?cmvLL7ROmDZEPTPmwvsrzzelliEm8x7OGdg5VbY4XjI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ef4ca4-fc66-4f46-c8eb-08d8959cc3d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 01:59:40.4588 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nXdMz9zwIRx5Yo/cIXYRGAsCP794yr7C6xcYM4zj9zGuT9mVQGgfzL9zZ/1xP6Fu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3867
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

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, December 1, 2020 7:13 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/powerplay/ci: return an error of copying to smc fails

Rather than just silently dropping it.  Also fixes a set but unused variable warning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index 329bf4d44bbc..93a1c7248e26 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -2193,7 +2193,7 @@ static int ci_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)

 res = ci_copy_bytes_to_smc(hwmgr, ci_data->fan_table_start, (uint8_t *)&fan_table, (uint32_t)sizeof(fan_table), SMC_RAM_END);

-return 0;
+return res;
 }

 static int ci_program_mem_timing_parameters(struct pp_hwmgr *hwmgr)
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cdc04b379d57c4d96929b08d895858b0d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637423748100898322%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=4%2FnT%2FoAlE5Yj5T2nyzQ1RgxAW21BZRbzdHnIml7gYaQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

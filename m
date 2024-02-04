Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9855EC48286
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Feb 2024 06:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21134112081;
	Sun,  4 Feb 2024 06:13:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FfB9O1hv";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A24A112081
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Feb 2024 06:13:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3hVLeczcLoc9cOiScmORNJgkOx/ybVhmqPyrE3r9veYV+YtisygeE4Mls4noM10flGhCZF/I1q+JAvuqC1yMDRJ4e7IaiLHmZvrDaD/YqONhxumSPyYhgUREYFTubpd2D2GRqqePMjnxZrr60alPPlBfOAqPxnOimByVb92jyamLhn7n5V+l5T+Scqnnzs+nn/HV99F71KAi24SnLsuQ+m8EPrxcNix76y4N02p7qSegZ7+N9K9MTwMmL1I1Cvav4c4qRhqqCdr19l4CGdN5pbK31kmrI8sMtKqQ2SK5wp0q1oLMyEOq3eROSdq/Z7hAqW18GdsikzLajjTHVanmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AB4LIEkujCY9bB7P5tOnnHYWh5fszua19NwA7+CqMVs=;
 b=hHgzxVfzX04ZCua11wcjVBlz9J9gkmZkk6LPN/hNXTrHFiB1/lmfd88rLmQXwr/24EQjxN2gFGmmExUa/XmolkLZQGITQqWoWUHyLWeRjOGJmZptxGS/VLtUzP8eypsGR6YThCOL9QJqjpjXkRTYYGZWxqv0W7v+XT1iaHgRAEheupiAcbtAswGbvSOJuNnOoEWh+PhRaDRPezVzbOHKEznlnPmNWtw4lI9rdDOywODMRm8HWtfEv9rWlEPSMmMWb6h9zCy3kOg/W4w6/EhJlD2MtUkj+DhfNUEK0M4DAp7S0pZiO7hnn8DxQsnXB3Qbdl8zAcGaK+BTXldheHa3mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AB4LIEkujCY9bB7P5tOnnHYWh5fszua19NwA7+CqMVs=;
 b=FfB9O1hvWR+aq3KuqKOeMkpn9CqiH8E3SsETZYREtl7YLNbh/eR8xu9oTsJHCiIvM3DqkF1VbLqBN6rk+dK2SoF0xs38wGCGT9na7SldgZULEYIucx7sYoI0Li7dUkDmWs3qL1tgj0wKM3UK18H1rtccckQBvvFYFpN1lK3b2K0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SN7PR12MB6931.namprd12.prod.outlook.com (2603:10b6:806:261::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Sun, 4 Feb
 2024 06:13:10 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81%3]) with mapi id 15.20.7270.015; Sun, 4 Feb 2024
 06:13:10 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Retrieve UMC ODECC error count from aca bank
Thread-Topic: [PATCH] drm/amd/pm: Retrieve UMC ODECC error count from aca bank
Thread-Index: AQHaVcjL+Pwd58NMfEC+Gflno91ZebD5tsfw
Date: Sun, 4 Feb 2024 06:13:10 +0000
Message-ID: <BN9PR12MB52575E416981AA3AD3345DE6FC402@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240202111230.1153924-1-candice.li@amd.com>
In-Reply-To: <20240202111230.1153924-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c4780c05-0e2d-4ab3-9d37-4876caa9624f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-04T06:12:47Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SN7PR12MB6931:EE_
x-ms-office365-filtering-correlation-id: 6f93c4cd-1d3b-4443-f48d-08dc25485d05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7dfaiDOcA2K1vDLSyOWJ5WPDGJ/Vy2a+njVXMC3ilW0/fxliNtFTe+W3wgnIDPlaJNScxV5w3TNbpUzRa4h5e4vJgIhN2zRXGCjqZc1/AIEir5WZbXNYkK+r2XgnyMiTAV4QwUGlOjADHjTfA1BN56umJUrkg+jajdr4l2YT8p8+BLir8ueDC7TRf+TLbllELcpLWTlDt+dtXWScAtUY8rOJxl29WFyzq5CR6LjBZNUaBBVKj+Kq3u29W1VkS19JQFUDuA3ygxh9BawsPR4b2xD7pusPbMYmPtSDyQHZjdAW2LFYh9RanPrq62r/zjaMqcjLv/NQCDb+JMPYdujvRldFd5OwpUTn32Af61yHnT8OJuHZRWMshWSw7UFTDi7+i/W8CDOElo1Ni/Rje6Jk9ifRG82p7j6xlvlnZihC+K4CKcN5W+u9Ks0wDXi8XLuyhsfY5DetXAxkcYanSv1mYg5R4e7JddkM/wUlWnyBO4O0JSFp3aDlADFW3YB7lXwAzKB56YyWF7sIdffshAGv84/srnEZkNOuRk1tGCY7YEJmK9Pyw2KzQOS+iqRkzJQkGLGgkiNgKN/TudKwYZ3VJoF3502WlGmsz+OyBS923PzsuKezo9byb4/uovFNvEGJvHKctFkIKfvp6JYhrawDCg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(41300700001)(83380400001)(52536014)(38100700002)(110136005)(66446008)(71200400001)(8936002)(8676002)(122000001)(316002)(2906002)(76116006)(64756008)(66556008)(5660300002)(4326008)(66476007)(66946007)(15650500001)(6506007)(7696005)(478600001)(9686003)(86362001)(53546011)(38070700009)(33656002)(55016003)(171953004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CwLR5eJIMNMWV8MnK8rr215SO5N8li+3EwkBfqaToRzXHK+5sXBUBIb6EPme?=
 =?us-ascii?Q?6s6ZtPptBZ9AJ1x+CigpX59WVKmEipBT7YCudR3x35RnnAVODiYNdoQd6Kfy?=
 =?us-ascii?Q?PyWgTNo1r/pg8yejw+QFjSzzKz2smIL2siDNa03mfRJ+B96ZqJquBDVJbsWk?=
 =?us-ascii?Q?7/vD6BMNepek5xFz5RWspHxnQussQQXwsaIqKakQfvKi1omgc8WsVb5gz6MV?=
 =?us-ascii?Q?pHdieDIGx0+SHY7ouHvqmrwT8SVqDgI4QVHJfig9SSHqVuDP2F4JvOiYn1ap?=
 =?us-ascii?Q?SuXfeNQ2xZ+u3LISPrEFf2xu5psvMj4lig4De19da6IlLw3c9zlqLa/6UUPx?=
 =?us-ascii?Q?idBwLvD6Dey8jn+BG2V73CuCuXYVeBlzUw19j6WKC7fPXZJno+8KipujSqSQ?=
 =?us-ascii?Q?qk2I+5yj4CWL1LBt3vBSPQcd3zcno3ha8tBj9vRO7DGWgwHlYVPLwanD4tJf?=
 =?us-ascii?Q?lhUQzr61t9Ysx80Cs8M39jVHebZfiUWcEAybYLg4IXAJXfgmMJAsfoi4lBRu?=
 =?us-ascii?Q?vW+zEYhN0BLv2KeTrGFqj7iTBkJvUhTuXtAcEXDa90iQ4V12eSHC12ikr1h8?=
 =?us-ascii?Q?HG3mFLxcNsZWBdUk37oMYBdllKCR/cF16KcJdky+LN0nqQYUYXDfqHJMW+/X?=
 =?us-ascii?Q?eY7OPYPrG4+0bCTysqHWvZ4YNJfpuUyx/kL27TaCvaI9imk11wmrnPrqWJLa?=
 =?us-ascii?Q?/ZbPPZO1hLwZgF3DBmi+6+9I1kCT+kKbYyjIYSU63tTVZpIqY+SqR2aYejFM?=
 =?us-ascii?Q?DgrgSmpQKZy55N3TzHALz02iqWFuBNVEUMRIgNaAyhF9JqNnq5InepnDow2p?=
 =?us-ascii?Q?h/8b3+eedDjwvQNsmePN1gTx5DrmzIZRyQM3EQ/WBmSBOdk1BZ11rJXsR+nu?=
 =?us-ascii?Q?4JZiiLqOF2b+gX70EViSQMNpDVEGB+rf/etXL3setEjwdNT8/8SpDLyuuohf?=
 =?us-ascii?Q?cb+4eQ2QW5i25ZPB7FfE3PUc6dZfl7iimRHg9A57Sp6JKRgPnluc/s4vf2q4?=
 =?us-ascii?Q?kvwctWeghyXrJyZ5KPJQIZbBxMs5f3opxWLc7GeBpEBtuhZ9XVCwkOc5u7f9?=
 =?us-ascii?Q?hWVTXYUN5BmDZfMvYQ09dphYAPyhmwl2wryf1xw6NOvU9PpnD30U8ikPEp8c?=
 =?us-ascii?Q?35l6ZyNm8CiQHAb5V/SE276iQiUJoBoizgsnTmzQ9l+QWn6mSTOvD6YYkc03?=
 =?us-ascii?Q?AyZhyZpDzTDNa8YOm+NMTk14Xe7+QNzeWcI+uW3tn7BvNB6WDLDzY2Znmb5N?=
 =?us-ascii?Q?hWl76gFUzDMeYQZtsWS6fBMsZxelEnS4dTds2EtbLCwL/L8JsUBEAJiQ7dCI?=
 =?us-ascii?Q?RdUFS934NpVaSb9hsbL//ad7NXMRYjOvW4g0OPaIN5n7ucq08Hf+DoZ2ZHUs?=
 =?us-ascii?Q?g1RqvWAUV1nDLaIPW6GrGcD70ueez8Fk6XmoCldpa2361I1Q+FdOec8BwrrK?=
 =?us-ascii?Q?VcsJvSGdqVRrCqHV2GZ7ot6FhEyB/m9pdKd/w2Rrmea3tZ8qze6jgZgCJ5qw?=
 =?us-ascii?Q?JwTB23FTQ9H/y/9ogikF0zJunQrVxjLjj3ptcXdEvszE28usu1+UcrWlLnG5?=
 =?us-ascii?Q?ho9cTeF9MWyX08HL1lc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f93c4cd-1d3b-4443-f48d-08dc25485d05
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2024 06:13:10.8147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e6tOUllRRS+AtPquj01ckDGDgU841esGZ7LZLqLYYVEEHhqtlU5qIdogsr6WH+bjZyan4wci0DEknWOxAnctYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6931
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

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Friday, February 2, 2024 19:13
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amd/pm: Retrieve UMC ODECC error count from aca bank

Instead of software managed counters.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index d6e14a5f406e63..03873d784be6d6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2552,8 +2552,12 @@ static int mca_umc_mca_get_err_count(const struct mc=
a_ras_info *mca_ras, struct
                                     enum amdgpu_mca_error_type type, struc=
t mca_bank_entry *entry, uint32_t *count)  {
        uint64_t status0;
+       uint32_t ext_error_code;
+       uint32_t odecc_err_cnt;

        status0 =3D entry->regs[MCA_REG_IDX_STATUS];
+       ext_error_code =3D MCA_REG__STATUS__ERRORCODEEXT(status0);
+       odecc_err_cnt =3D
+MCA_REG__MISC0__ERRCNT(entry->regs[MCA_REG_IDX_MISC0]);

        if (!REG_GET_FIELD(status0, MCMP1_STATUST0, Val)) {
                *count =3D 0;
@@ -2563,7 +2567,7 @@ static int mca_umc_mca_get_err_count(const struct mca=
_ras_info *mca_ras, struct
        if (umc_v12_0_is_deferred_error(adev, status0) ||
            umc_v12_0_is_uncorrectable_error(adev, status0) ||
            umc_v12_0_is_correctable_error(adev, status0))
-               *count =3D 1;
+               *count =3D (ext_error_code =3D=3D 0) ? odecc_err_cnt : 1;

        return 0;
 }
--
2.25.1


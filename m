Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D142BC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 14:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5578F10E7A2;
	Wed,  8 Nov 2023 14:54:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 137AA10E79F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 14:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKVBjHxsGMCX2zar9weAFWpChFVrEXV5tLbR5Ebzf0j/KxlWGTVn5+z46iY0WplLlaZj+fKP1csAh5jjcvAviakXqIQnSOsoXZBg0q3uHvkMSZXo5DqPeNAPtTyrOrXn/gNkBlPvrD33fujSK0s+0l5y9q1XZIbUETaqj0wIjkxuMcs3zrMD+X+jfHVLKIbPqTOISmhZPjnkEe9cWFZzyTwqvagTvsH/Z0iHonbrG/KXmzJIG1JRHyYGNFO6QNfsh1ZVWRnMjzC5UaH9N3Ic0ME7tRlgrshwLF39TU9+z8j1kduJhXcGwTP9gqKPOXj+5ydZDlJ8KLRznFYEYdXp5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGcH539J1Gyl2kq60UBYU334gjrAfHD2faQ9FtzBX7Y=;
 b=e0oLsCmz0OpZjrNCYbhkY01PqVm7WIaS6H4cQKHKpTx1ZbPKUt5eMaG521WQN4UIuMhfFQPJ9NdC+u8x0GFzw+qXMQwwXs8ZTe/g7DHMMqx/H+hWM93dTxgz6BnQM9BfZY3EZRZk0yDQHJ7t8qTcEcckUT50Moh9eCSEdP2pRlQUtAijIcgwzqiNPwQvgo9moshvY2qLHCpSmN2CmPvU9iYgJlCZwlJVYFRtvgz5owa05VWBwOT4LxeAZ16eoqlxLHXL7CETJy3CNRmotO0041Rw6yGWKSS2BgWoWCsjG0qanRN9qWidGauX0YnP4cui4viEhWW2UGVNxXT+0NiRyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGcH539J1Gyl2kq60UBYU334gjrAfHD2faQ9FtzBX7Y=;
 b=eGLHxm8zsHspfM1fwecFUpf2ktGyjaSZFWOP+/qkd30Yzxji5l4IKLQsvpE5MFErMGg95Vgvb8DozQ6AGrzwzZkbhdoEwWMYJd85ReFJHhiE6Rp7GhTkDEpfaRIc21/kK4HisntbUkts/OrAVA/5YuYOJ5yXilnKm8LxLsIF6c4=
Received: from MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12)
 by PH7PR12MB8038.namprd12.prod.outlook.com (2603:10b6:510:27c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Wed, 8 Nov
 2023 14:54:18 +0000
Received: from MW5PR12MB5600.namprd12.prod.outlook.com
 ([fe80::36d4:54ac:e00d:bf88]) by MW5PR12MB5600.namprd12.prod.outlook.com
 ([fe80::36d4:54ac:e00d:bf88%7]) with mapi id 15.20.6954.025; Wed, 8 Nov 2023
 14:54:17 +0000
From: "Dhume, Samir" <Samir.Dhume@amd.com>
To: "Lu, Victor Cheng Chi (Victor)" <VictorChengChi.Lu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Do not program HDP_MISC_CNTL in hdp_v4_0.c
 under SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Do not program HDP_MISC_CNTL in hdp_v4_0.c
 under SRIOV
Thread-Index: AQHaEbEwlN4hu2RFk0WCj7mCnq8F+7BwguYQ
Date: Wed, 8 Nov 2023 14:54:17 +0000
Message-ID: <MW5PR12MB56004BB3E9D96CCFF6F4E62AE6A8A@MW5PR12MB5600.namprd12.prod.outlook.com>
References: <20231107193210.2375-1-victorchengchi.lu@amd.com>
In-Reply-To: <20231107193210.2375-1-victorchengchi.lu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=83801264-735d-4d54-8c3b-345a89330849;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-08T14:52:06Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5600:EE_|PH7PR12MB8038:EE_
x-ms-office365-filtering-correlation-id: 21d68ee1-0ebb-46c1-9f90-08dbe06a954a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PkzEVt9TWf4caGszFm72QxCQxUrVTvIBaN6REWwGJQW7LciKVTqaE/QjgJ0oj+XRjla7eTmC6GKj8vI7p9UXz85sYd/oSegm9P1+QoT6A2al3ih/Ym08y7HAVODbEJ0p96gg9xPgWgN87InBdSfFnsmxHC26tiipFSQgKk+11iWNyhcT87H9fYgc61pttk8VKei9v2sJB4n/2vr9UUQ90Akk+0tyLNJiQxXyYuiRYkU2wm0wrLaf3ekpjxL9FT1nzy76xGLvoot8bImR0seKXxp25G0VLKc0yNhFAX70pGGje7XUSECiKcj5etkuu85vGnbdkjP89P/HPbCL3Gk2tSH6TBnnSj/LfKFqGqxFpumUNlPegAkidZa5bdvhLJMkjTlA+JTz0ddwrnetFyHSAaIkt66UlUZG6C1q54V1ODMdQwdyVIS7WjhRQXwNyKGp2BN/v0+/ee55Wm7PQ7g5TPFWeWL2pPV7A9plbfFxr2stGMBzZKaQg/s8ybiIqb8qt5WtIW1xwliDZaOh/HsHFDNaxlxXyH6Rac4k+VGrD3sC5l1h3S2tQxjhZyP/xsdF5QctIBcktX/zMCzCpaxPTa1amSczKB0ZJlXiMJ5KDffXEpPI6bO3MV41vxm66i2o
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5600.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38100700002)(55016003)(8676002)(71200400001)(83380400001)(122000001)(66446008)(2906002)(76116006)(110136005)(5660300002)(66946007)(6506007)(316002)(66476007)(53546011)(64756008)(7696005)(478600001)(8936002)(33656002)(86362001)(41300700001)(9686003)(38070700009)(66556008)(26005)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sJoBkFxHE+vCHthRI+4GkJkEFBrKE9GsazXegU6MS/dMQV5SFaTN79QAMbfA?=
 =?us-ascii?Q?cKd6OdF2fOFq9Dg4VJLZxacVES2tXr9ouc0smy7y3ILjwvjT+9Vzzku7SEn5?=
 =?us-ascii?Q?h4HcWfiGQzBfaCvlkTGC/iRquTVmBHpRtUf+ZZFhhZMZmyodN7IXm+sTsrcS?=
 =?us-ascii?Q?6UKodxrs5LUofkrxgQjnvGEzxUydWPCWVfYxfO94iEMTuIQllhpCs7OjW48d?=
 =?us-ascii?Q?dt7z8p0Py8bSxLKCksImE1TjNhAwQ5EzPZu4NCMGDGFi9trZlUaQXUBjyGoH?=
 =?us-ascii?Q?Y37984uH+ravUEps9j7L5SHGsTdAClULhVo5CWQ4ODwDM2yUU25mbosSaGJD?=
 =?us-ascii?Q?gkZKFz5eFKlKDK4KMB1i0lHXneaAzcZl2otxvACed4kvCe+emCWkpu4Hor6N?=
 =?us-ascii?Q?9lL20jIAA+iFivXUFopq6wZBCXi/nti+2qsYqBonw43187pBYC9xqTSOJWxn?=
 =?us-ascii?Q?icKHQeXJIwgRGcR9jFowXasZSM3T7sb5OEbkJMxJHSTePJ+437TaJzl6WOYq?=
 =?us-ascii?Q?/PUNCDtt5yk9AuEDp4T7n4WKbHvKgJm1ssuQWmVrTvBCSIpOvWt2Q7yHEbgF?=
 =?us-ascii?Q?Wb41mqDjQWrg30Cto5kStIL+xmw/rEL4ARKttv4kLoNhBJAvxLqMR8L+SsYy?=
 =?us-ascii?Q?+zEO84vHUaYqqKTAlhonx7Ef5CwDicDmHvvDeLMGmQ+kiOJVcO3ORrhoHI/k?=
 =?us-ascii?Q?zKQ+oraCh2WrHdVp2IFL64PAHvSSPRoncU5ZBa6FGz73KHQ8E+wen33Y41e/?=
 =?us-ascii?Q?aQ6kIbD22spxdETSEhASJRsQSdS1pPxbgbOJhVQ60vJE8Fmi8I1uh0NBQShm?=
 =?us-ascii?Q?cKKRlU9kw4XO7ZtgIpe+pCvhzBcIvO+Qi9NOT63geMxN6z8yzqYu2pyxhNhR?=
 =?us-ascii?Q?VfJuyqZv824eIjgMKzVTFBNKvRQUYBhnmWyvqNBPHufv+ISrP+dtEWxznbjm?=
 =?us-ascii?Q?jsS8Qj4hD5Zg0tBeYhVkGNpm7ij0PIqYqjXzXVRr2SZ1n4m3i4Ti083I4h46?=
 =?us-ascii?Q?WmTCSVrK9FqzAdwzlb495eCZMwjKAYwCrppScsBmuyJGERcyQl++2CXuKrcI?=
 =?us-ascii?Q?pCv9INoW2+VI4yQVcy012evoG+6wjj4TuaJ9uRWeURrs/hdzwmlYQ7byRCU4?=
 =?us-ascii?Q?ilA9w66Q/8CvN7MNI4b9KPvFTdH5RxZC9pVdrtn91atTYs2Wovnp7xxWNPKe?=
 =?us-ascii?Q?LFss+5wxR1sfYV4zZFZKQV2JX4fub+sSmW9BNsGLWsYylkGZwyCyjpl3yQV9?=
 =?us-ascii?Q?LTAS16qQwuN2KSrSeUT51+2k75hWY7Gc4wY79pP1HlEZm10VOQy/ZJcNFeyd?=
 =?us-ascii?Q?6dtAqsq6zOQtV268BNzizhwOg9q0fxSYqKCJGLK/dj1dnbY7R5MS7nyhRgaK?=
 =?us-ascii?Q?EIRbAoFVGMqhwoN2awPEwgVrtuDdtlGMoB+19mGYJ2hxH5F4zMVY45I/sr9Z?=
 =?us-ascii?Q?v8qjeSJhan6C+3j9xWWJaKJi9CmjskaeBAxZNNEWSCiB8cLNUyBDMrPKIqcS?=
 =?us-ascii?Q?macJ6TTMHNp8u877ltLNCrGdjfEcdBQAy6TTEhyintY/TLKxT9CRcUqc3pa2?=
 =?us-ascii?Q?2syFuMWG5L/5B1dBQ3A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5600.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d68ee1-0ebb-46c1-9f90-08dbe06a954a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 14:54:17.8899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yqBfE0YJlzIUaypH/3iRzUVC6XWIKPcp9SO9JKm4FtVbTFo4DJ/YnzViiJZy9pBe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8038
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

Do you also need to skip programming of mmHDP_NONSURFACE_BASE and mmHDP_NON=
SURFACE_BASE_HI?

-----Original Message-----
From: Lu, Victor Cheng Chi (Victor) <VictorChengChi.Lu@amd.com>
Sent: Tuesday, November 7, 2023 2:32 PM
To: amd-gfx@lists.freedesktop.org
Cc: Dhume, Samir <Samir.Dhume@amd.com>; Lu, Victor Cheng Chi (Victor) <Vict=
orChengChi.Lu@amd.com>
Subject: [PATCH] drm/amdgpu: Do not program HDP_MISC_CNTL in hdp_v4_0.c und=
er SRIOV

This register is blocked for VF access.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v4_0.c
index 3f3a6445c006..bf3bdf67abb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -145,6 +145,11 @@ static void hdp_v4_0_init_registers(struct amdgpu_devi=
ce *adev)
                break;
        }

+       /* Do not program registers if VF */
+       if (amdgpu_sriov_vf(adev)) {
+               return;
+       }
+
        WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, FLUSH_INVALIDATE_CACHE, 1);

        if (amdgpu_ip_version(adev, HDP_HWIP, 0) =3D=3D IP_VERSION(4, 4, 0)=
)
--
2.34.1


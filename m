Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11329C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 02:50:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73DCE10EAE8;
	Fri, 28 Jan 2022 02:50:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4CD010E2AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 02:50:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNZhHQ2V2kL8slywOzRFeyV3GL3xttexRBzYhenLoXuMJoQZ/m9MXR+hmgoNN+lCDrp2Sku5UdrW5QF9KM6E/SYHOllfYkRxcghuodB4+Bz3m3anbjj49GjCqBMeU8K7+2qJQqyKfnfEe55lIxMznvA0xS7Ww8PdlVd7gpSjtlc3I8VMa/hoD7uY/iXeoCfaE2IhHrVUF1ILs5flU4b3DHNQQXsj7CgbYovCSt8oCvs9Y4A3LMS/IjHxKPrm1D0fXA4PhjAM/mjO+vy/AR2Nu2xuN09oWxKYzZkF7KTwpjm0pco3mtxjTO7uOMK6WKgZ8OOT6yPC7N2rnFevGyYRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgekm+haYXHIqB8dvlP4gOZ4sJR9+//bIZfDYIE9f2A=;
 b=IhNewXnth7w0swSZ7x1oud1HLdEYMzDjnNl4zs39AJ0eeFB8x+ekVbYN09lODmvygnZPdenH+xbsQgC1iNC2V2MVysr6GOT9xRPS8b2YcubFhzi/TFzoKNaADe0kQW/IDle+NorjGkt0o8GnORWOxSuuKKFC8H+pSUA50xKCuK83i80oaLtMPLug8+s5pYI6BLBjqctoalG6dJqIK+F193963g0a1z92eYX27Ed10VPBbjs5vxiqB3HEwZIvaKUKxkrUu5bQqyH+eHuHYGehruPuq3dnb29eN6eEjEn28mFZbV3GAkWnlrVVz9f5JHJV/l9eaMG7Y3iUE/I0NoGk4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgekm+haYXHIqB8dvlP4gOZ4sJR9+//bIZfDYIE9f2A=;
 b=yg+geHX5scx0g8/NKQJOUzy/vlOPnhOBze5QFbFq/Q2+pnFo735X1tsxxvdTt+lox04tghXXj3jMDn7eraxv0N52UL1P8LwYucAn66vdONqLyDhiReBZThU/JBn56U/DBGXaXd3VLEB5lb/SU3ZCTE4+QYPwLGfz62BdaqkcMh4=
Received: from DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22)
 by DM8PR12MB5415.namprd12.prod.outlook.com (2603:10b6:8:25::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.17; Fri, 28 Jan 2022 02:50:31 +0000
Received: from DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::cc07:fecf:c07d:403b]) by DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::cc07:fecf:c07d:403b%4]) with mapi id 15.20.4930.017; Fri, 28 Jan 2022
 02:50:31 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Charlene" <Charlene.Liu@amd.com>
Subject: [PATCH] drm/amd/display: Keep eDP Vdd on when eDP stream is already
Thread-Topic: [PATCH] drm/amd/display: Keep eDP Vdd on when eDP stream is
 already
Thread-Index: AdgT8XWfBXjrFHKiTZam0fg5m5OR6A==
Date: Fri, 28 Jan 2022 02:50:31 +0000
Message-ID: <DM4PR12MB521498A5B7AC85E8BDD6B5269E229@DM4PR12MB5214.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f7fcb149-88cf-4290-a4c5-c00e19c92901;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-28T02:49:55Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a29807e1-385a-44b0-ea5d-08d9e208f31a
x-ms-traffictypediagnostic: DM8PR12MB5415:EE_
x-microsoft-antispam-prvs: <DM8PR12MB54153F4615D00DF0601E13C09E229@DM8PR12MB5415.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gwSGXBi88hgqbPfSU0dRx6S32hK4L3A11u7kjA4FMgDV1TjS0ITsRDUgGd0P4wTUpo+Zr1B4RUm9VWK2JVO5Pvl0R8Xu7Z3owncFVVE8zVmAT3DiV0MpsxBTcp8FUZStDhdgwhWOPmqDnaJa72AMrOThrIdkKMx/AngGRobh+CjagOEYxNEYPy/EW9wGLL9o3ty+WkNXHUiHs3D5HgFVBuoNClV89xhEjQIlwRhzdc1QzswM4onlHMAnpebutfZDH7chgiHkBBhn4+ReokOOaL3LnVm/drXZzcuro7b6ZheRs9GyQN7xXxoNoWdVQTG8TqpbR6YrKgIYaeAhmxhLBKQDySUArBPRZ1sJg8SuwfKt552lnazTdNLeXftcTMwg7ACXxSXZ35DCFD1Yu8/aYpqRXLSTFP5tYlYAbenEoVkJPbbOXEmNwh0rLHtNSe7U07qDguJZBO6KaqPVSkGWBgkeHXEgBhdlbgLVFGJ86NfFIaCtyX7fA9ptTpoRAB0+ncIx+rp2k15WDGG25BPlyvw9Ru4TtJMqb6/sWFjSuBZsSLHR5MMQ4QAjW5I4OpDmWvQYHc1/qTFyAdvg0DVu6MZUqPwxf6htIgPCCJ9FRBFWqD6JKs+FdZCjzNgmq3dgQ2NLGUt4eBtbBuu+29cSowv+AchCAJCcdfOYHWXza0iw0cCKvt43nk2krCZ7FH/J5HgUyApY7sdGQxF1D0MTaw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5214.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(186003)(26005)(38070700005)(122000001)(55016003)(33656002)(7696005)(6506007)(2906002)(71200400001)(8936002)(316002)(66446008)(66476007)(64756008)(6636002)(54906003)(4326008)(66556008)(66946007)(52536014)(110136005)(8676002)(508600001)(76116006)(83380400001)(86362001)(9686003)(5660300002)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W8wsBtpD5eYlbqMIyxiiy4+rzz2RGDBiuzG/1wAwUXe5O+++oq6uSs86f5Fe?=
 =?us-ascii?Q?McVMiWL1ROwDJCbB1rsVxX226sEFKNWhVkl7lFO4Z9CgK68kUnNFw5TOjQ2s?=
 =?us-ascii?Q?eTM1F2t1+BjSxR9/BvMsKoetG7F++cVoFxviYYU5hZuJPLzlpLGsayvo2ccV?=
 =?us-ascii?Q?EHLqnLcQcPnlE72w1lSSeilLF/Vpwqk3Psf/f2N8LsHgm/8eDBcrJ3JPgreT?=
 =?us-ascii?Q?/OFSUt6XA2fML2tCRb1hWjfhfxZb3VefqFOviSlLgA7QOCTNgY/QoNY1+vF2?=
 =?us-ascii?Q?siS9WRQz7vnUXmvE3GbEpLGfVSo65oOBxJObrBiJ+GiQvbuU2hPiBmJVklEq?=
 =?us-ascii?Q?SgVF7cHoULazZGUntddX5cPI4c2suXfIseRy3D2UlY8IHIgPwRyLUqGlsDTj?=
 =?us-ascii?Q?xygpinHFmAu7M13k6jMPCZDHCIftUlZlhxrAf1iItzRKuLfST2lozWqpGQoW?=
 =?us-ascii?Q?NfPFNEGRBRDeXyZQiHhmJPdxA8gcuJM+IdTvnnJZRZvsCPzmoBSWSaQ+BioR?=
 =?us-ascii?Q?RT2IqOO+EhA8jq65SAA9gd7wXQG7xToHnu3fQgR0X+aU+4F0naUWI1GAG+gc?=
 =?us-ascii?Q?SdD9uAeFGdeGXaopAo2KsALNcjuY64/x01YBmyrp5xhNTid8I8DTdlzTBmNA?=
 =?us-ascii?Q?vJiXcBcZE3AJBureIJrFlhaWpDfhNw9PttlJZMtSEAkSPXkLQztcwjy51q8D?=
 =?us-ascii?Q?XIQ9paJ1aZKR4hcohSt75udlRI/kgagY8aTjocXeByzj6Z/bi27C/arzOPB0?=
 =?us-ascii?Q?KVfCcWjIXeFeRooWSrzrmdCnDpYx7YsRXDiX2RYbOc1toN+wKh4x8o3cvM8X?=
 =?us-ascii?Q?28EsilsuUEVy0Rhr71PEOD6k/68MDC6M+7ckcK2Kmw7Ty6rq/gFyJuxC3iMF?=
 =?us-ascii?Q?gsZPWBnRS/n32uLuDxC9ZE5bk/X0wIbwcUeqosUlZAJV/+QxFOLINGwCah1s?=
 =?us-ascii?Q?eHhFK+sO2kQcYMX8Tk9/Ufi4PEk6C4YDksmNErgvLZ9jSyB1Ffu0WOgSAoc8?=
 =?us-ascii?Q?EHuCLajyztCMuTNiUJ0XPnVYYUAYz3Z655R82bnfO7c27npA74iNbG+RAG9L?=
 =?us-ascii?Q?3cdUxYLGDqRtOupOfIH6FKfRqX+yNKBA1xZ/16wLngRI01XmsXh7fS9p+6jE?=
 =?us-ascii?Q?AAF5YxP6QSCSVAlYSHXTaItila7RDSN54WZF0Y+DloABFoZ5x7M535vkuIZl?=
 =?us-ascii?Q?CElRYkpg5HOvG3bsssuX9Eh8Nf9Y7C9r3Je1Q6JQfQpcDVoIGlmVw6NKSeeu?=
 =?us-ascii?Q?xrAUJ7G1jfqX80j8VZ5ANjuefhdCO9K0bueP8x4G1DTF1fctpuDq+knnTSRW?=
 =?us-ascii?Q?XpRQnLxBXUaK7T+NoE1zTR3zjnfzyIwHDb1alI/wCmAYgGq5jNbXHuDyRUf6?=
 =?us-ascii?Q?FPzCQiHdecwmXDwA1HpLFkrmWkPk9TYOZvs/urk7XJPsOIjH6qGcmou+Ck5M?=
 =?us-ascii?Q?Nsi8jzOCkuqSLECEPzCtXV6h96xhcAdE8NIKVzgpzhXRNdmPogmXO++L+dRl?=
 =?us-ascii?Q?PjUbUvYv08cUV9fsDvDcuPqNo7xGpoYjMHES0gXWtdCVkWlchGRzzitm0EQu?=
 =?us-ascii?Q?riBKfQYKIqwIgbELBhc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29807e1-385a-44b0-ea5d-08d9e208f31a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 02:50:31.5097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TRhSu3lcTiJCC3Pg7RNQQV1t+n4NoJEQ4DTdAcooYNsY9jboA1MV7uO2PqkPKvei
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5415
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
Cc: "Kotarac, Pavle" <Pavle.Kotarac@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>,
 Pierre-Loup Griffais <pgriffais@valvesoftware.com>, "Cornij,
 Nikola" <Nikola.Cornij@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

[Why]
Even if can_apply_edp_fast_boot is set to 1 at boot, this flag will
be cleared to 0 at S3 resume. However, we still need to keep Vdd on
at S3 resume. Turning eDP Vdd off at resume will result in black
screen at S3 resume.

[How]
Don't turn eDP Vdd off when there is an existing eDP stream. This can
assure eDP display come back after S3.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
---
 .../display/dc/dce110/dce110_hw_sequencer.c   | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/=
drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 72dd41e7a7d6..1aa6f2737534 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1796,9 +1796,28 @@ void dce110_enable_accelerated_mode(struct dc *dc, s=
truct dc_state *context)
                                break;
                        }
                }
-               // We are trying to enable eDP, don't power down VDD
-               if (can_apply_edp_fast_boot)
+
+               /*
+                * TO-DO: So far the code logic below only addresses single=
 eDP case.
+                * For dual eDP case, there are a few things that need to b=
e
+                * implemented first:
+                *
+                * 1. Change the fastboot logic above, so eDP link[0 or 1]'=
s
+                * stream[0 or 1] will all be checked.
+                *
+                * 2. Change keep_edp_vdd_on to an array, and maintain keep=
_edp_vdd_on
+                * for each eDP.
+                *
+                * Once above 2 things are completed, we can then change th=
e logic below
+                * correspondingly, so dual eDP case will be fully covered.
+                */
+
+               // We are trying to enable eDP, don't power down VDD if the=
re is an existing eDP stream
+               if ((edp_stream_num =3D 1 && edp_streams[0]) || can_apply_e=
dp_fast_boot) {
                        keep_edp_vdd_on =3D true;
+                       DC_LOG_EVENT_LINK_TRAINING("At least 1 eDP stream i=
s already enabled, will keep eDP Vdd on\n");
+               } else
+                       DC_LOG_EVENT_LINK_TRAINING("No eDP stream enabled, =
will turn eDP Vdd off\n");
        }

        // Check seamless boot support
--
2.25.1

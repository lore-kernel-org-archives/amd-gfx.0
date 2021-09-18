Return-Path: <SRS0=x7R6=OI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93047C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Sep 2021 09:10:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AACB6124B
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Sep 2021 09:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4AACB6124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C2C6E116;
	Sat, 18 Sep 2021 09:10:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 885256E116
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Sep 2021 09:10:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1dlWlE5q5GjXwMsFvxyrlKeC6UUpcg70B2qKb9KjGmRP+nIQeJvpICtmF1mlXZ/xphhyups2dImmSZboCbn0XX+RAxgdb2F89wpZjHUBBLGLNZrwbc3tjrDmhEcpF1jP77SZU5l5b0YO4Dse4FCIBo3aPr2tn3ATW80Fvhiea1XW1yDK5HdmizlyA5DrPy9c4QSwmnevY9bdh866DxUxt7gKFhsmOybuiy7llK51902I+0TG99EBK/tRErhlVkdSXpTrqjpAQs5GJEmAs8RKuth4on6KHZowIC8ypQ2+ec/HL5mA/CY1CJGVG3Aegh479wm37s/myepmviXwRFUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=eoAowN3orM0M1LL6f0QhFmOem8OW0JgGqS3wcBRXkiU=;
 b=kqkOK6x/HQW3Gq9/5Dz4V+BVCx44dkTYRXF0hCzVxSr4p9tsrnz5fFDby9mmKUAIcSqcXjE7nEwE/sdfsca9GYh2OtMAECWmFRdefWeixAgufMzXajkRekNlxzGGiF0XizsLp1lq/JEYa0BsUZ+4idWLxUB1jU2cN1E8TpHW1iLCG8+en5M8ICqV/kXNRmIjQBFZXxHXgT4g9DOytf7xrDxj3mA7iASljNWQqb0S5AzPwZATWBOGw81CFzEtHf/nEwNl4oovJ+x3faOYJ3cRv6oGrIVp7Nt07NGjCpLhQ0MleuGZeyqnqGnGRyFRCdJbhGrnoMpTSV+H67cEhqTURw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoAowN3orM0M1LL6f0QhFmOem8OW0JgGqS3wcBRXkiU=;
 b=iApRt4GqqelCetvU6D3pNHJE9XD3hsvh5/3TNEllTKQfNNF0dRiPp4kdHxlE8QNBZcqpzcUmUMqCR6wt2x+NNEFmg7xXesmll3c7xsgUDtyS2kzt7uSgXhLMpSlSYT3dbNbNMu38d/Q0M0Vn0BQ4uQNRjeN3zkqwayCCVtBkOfU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Sat, 18 Sep
 2021 09:10:21 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4%7]) with mapi id 15.20.4523.018; Sat, 18 Sep 2021
 09:10:21 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: skip umc ras irq handling in poison mode
Thread-Topic: [PATCH 3/3] drm/amdgpu: skip umc ras irq handling in poison mode
Thread-Index: AQHXrGRVHOLalBheWUqjhPEhZZuW2aupfmUw
Date: Sat, 18 Sep 2021 09:10:20 +0000
Message-ID: <BN9PR12MB525732C5691EAE99A0FE6DEDFCDE9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20210918080751.23615-1-tao.zhou1@amd.com>
 <20210918080751.23615-3-tao.zhou1@amd.com>
In-Reply-To: <20210918080751.23615-3-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-18T09:10:18Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=0ea8728a-bda9-48b9-8109-57615a5c4a10;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d4da255-f76e-4230-5496-08d97a84242c
x-ms-traffictypediagnostic: BN9PR12MB5226:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB52263DEEDDACA4674D5AD5A1FCDE9@BN9PR12MB5226.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5I0pHtCSE6GPFWNWDRS2Sz8WIzyZC+/76WKwKCDdJKXTug7MefHA8jTuYE0xSteJrH/faqB2/A62EhCBFizqIf6Um40meuUDclN3MgLeZnfIlTmUByh9srtAHa+BzRK2nVnJ6HzqYdevH7ye+i5HvFwIg1B4IHIcoFIgQZBJjAVrgwWlSbu/6ELcFq8ZQtTaiFcnJuW4WezIg40QOkFrOOqJjvX9GrVHra+BdCVjupJNUwhdT8c6B/hH7Qn9WopLHK8/Y7HSGye4hygY7i5tEPqQEDzGAJ264RLloXOd5Eudy2R8wzjDfd6hFVYMkwgh/q23w4YrPT9MaghDGQYyzs77Esp6bjR35eLjpCWsfVC12yuE1OzvP5mBoo6Gq4CpCQiLfZSTvA9Iu0MBJd0b9ptBQ3onYBTnEdOPG7hDBLYjbkEvDxcYtZVKoYj49Zm1oXyPUOWqPyMoEYWoQdPzCmRtJeHqoMyKzaVnfAquphNtRAQQWXJPHsDHCh36lsDFFBTMZ2k32rEpaNqI3jomctDU/XmNNohvbh2Q7U1qaURMTShbysb1ry6q3aPU89j23q6O7RhyqDW9CGFXWcS3vg41vQM0g1WuYaiQothQ3k4wvzSc8D5iN+3j8VuozryGpp0zcmMs1Hr7uowlq05uvmVhrKbwfA29D5iNLQbQdeF6RHLZnP3FFI3ZSd0VP/KuGqqwS/d00oC28tFw+TCBIg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016002)(122000001)(38100700002)(86362001)(186003)(38070700005)(66946007)(26005)(33656002)(5660300002)(6636002)(110136005)(316002)(66556008)(7696005)(8676002)(64756008)(83380400001)(66446008)(9686003)(2906002)(508600001)(8936002)(6506007)(53546011)(66476007)(76116006)(52536014)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iHPFzbPB+PCwICadk6hDdoM7mBDsLGqICsUQ6UHMGhL8plC7xfClz4WBNaSn?=
 =?us-ascii?Q?S7dL6PM5W9PAvKIpDRSXueS1+11zjbi+VVVy2oUycMXIXSi/l9AhKjDDKVd1?=
 =?us-ascii?Q?iD3YD4FwNdi8pf028vCf+8RN94EyTHbEY0KU4XMqqTVFq2XFdcIl2xfn+gOi?=
 =?us-ascii?Q?QGWqaNgVPR/2+fTz9fQs1/QnodIWDz0BI3plbSfT9o1jbRlY8Mzi91SotFoX?=
 =?us-ascii?Q?nQyXw1RDofyzir+DneNovXNM0QjtqLaNhrnTjXZFTr+5v3Dt7V9FRKc7sys5?=
 =?us-ascii?Q?A9Iy1gHrEnAyERwtmawpnzOllmcK1XKLPPKd3/Gm3q5SC7tnuVxQbzCraqEH?=
 =?us-ascii?Q?4NjBeT5XkGGBUsRBqQtmCax16CUILIETcRvjxLZTsDJozPoMafL+hL0RVnOV?=
 =?us-ascii?Q?QWtbS3iNCilnBpDY1Q4/cF0sNn5/yI0aFdzVoBaSvzSLnJZNN26UNsJoITxz?=
 =?us-ascii?Q?zQYMwmdL1Qf7CdjUmTHqEFeRy8ijMKTKbHkaUl3Pr5gsIP977U4KGZOwvr1V?=
 =?us-ascii?Q?5+LAQDe1gAAn3aAf5TkTmyKc3e0kmFYjibrqWoMup3qfejoWzWy/wRB5eU5H?=
 =?us-ascii?Q?xCw5saqhSP0lYezX7XipptnCSQxhcjIxAHIR2vFWFl6sC6gfa7L0oa8F1uzw?=
 =?us-ascii?Q?SNSWV1G+oOFgoXTVFimTDSCas/w9uAgN691i6oMJu/t/pf1DFEcIOWlqtCCp?=
 =?us-ascii?Q?r9FaPFeoTz0kneIUFT2pNVL/4BvUxhApGrranTOgyrL2zpFYLF9frkVlz8Gy?=
 =?us-ascii?Q?/Zg0uXyDjViau+z9O/fEu9QP5svI1YiDZ/ulUPcC3LJEw/d6KpZal6VZrPmY?=
 =?us-ascii?Q?ej4Kvn8dAgm0+1QvsNfLzIcfEDBoqemzI072QyGSeBBV4gJd9QdypArKsJaZ?=
 =?us-ascii?Q?DONa2RwY+lC1etVWXrfPTITfLbNMet3Kz5kapmbmlQom5oOC31dM6nh8miSM?=
 =?us-ascii?Q?spAqvOqZquwSbx00x0jwA74tTo1TVb4ejWCn1k13ZuKKeYyKEuQmO3u96luR?=
 =?us-ascii?Q?IpIlm2Thptn8U3YlV9T/E9AWppU3H0MsYWhcsvPVs3o5RnSX/dXulyBeeAyR?=
 =?us-ascii?Q?Y5Ffrf8/7+JOpLvpQUNgC6q708kkUt4Xn3cJdXB/wv/M9E0XjK3BX1ylLn/S?=
 =?us-ascii?Q?syip9gZ7UDpD3WWs11abZW2UOHfzuaP6Sjtmo7dZGilcJ+y/oQR7oTEWINjB?=
 =?us-ascii?Q?lFWpPefbh/jYOwXTs6m+fYmUpgBu+CDK7kEKgFXvpHhW/Z/rcL6I0tUhGQNV?=
 =?us-ascii?Q?x9UdB6AdeNLvg8eTNDOFy+9gUKRkKOnJ5MuP/ZS/1juW3GLT7cGDnhGWM2To?=
 =?us-ascii?Q?h1aU/bNSr2VYvjMLuStqSGbG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4da255-f76e-4230-5496-08d97a84242c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2021 09:10:20.8881 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UDy6MFsDNQZdoF3ipQyzoBnliCyL9+YvUbTep7vqzIKl3twvkHS1RNR+gaRzctLcz7q4R+QutHQZdqzwjE/+ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5226
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

[AMD Official Use Only]

+				dev_warn(obj->adev->dev, "Poison mode, no need to do page retirement"
+								"in UMC ras handler!\n");

I suggest make it to be dbg message or just drop it. The message more likel=
y introduces confusion to regular user.

In PCIe-connected mode, the df_mca interrupt is used to inform the poison c=
reation, I'm thinking of one the following handling
a). even do not register that interrupt in such case *or*
b). make a new callback just used to inform user poison creation event (i.e=
. leveraging umc error address look up and convert function to get the phys=
ical address, explicitly highlight this in kernel message)

thoughts?

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Saturday, September 18, 2021 16:08
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Clements, John <John.Clements@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: skip umc ras irq handling in poison mode

In ras poison mode, umc uncorrectable error will be ignored until the corru=
pted data consumed by another ras module (such as gfx, sdma).

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 34 +++++++++++++++----------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 7b7e54fdd785..195637725c7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1473,22 +1473,28 @@ static void amdgpu_ras_interrupt_handler(struct ras=
_manager *obj)
 		data->rptr =3D (data->aligned_element_size +
 				data->rptr) % data->ring_size;
=20
-		/* Let IP handle its data, maybe we need get the output
-		 * from the callback to udpate the error type/count, etc
-		 */
 		if (data->cb) {
-			ret =3D data->cb(obj->adev, &err_data, &entry);
-			/* ue will trigger an interrupt, and in that case
-			 * we need do a reset to recovery the whole system.
-			 * But leave IP do that recovery, here we just dispatch
-			 * the error.
-			 */
-			if (ret =3D=3D AMDGPU_RAS_SUCCESS) {
-				/* these counts could be left as 0 if
-				 * some blocks do not count error number
+			if (amdgpu_ras_is_poison_enabled(obj->adev) &&
+			    obj->head.block =3D=3D AMDGPU_RAS_BLOCK__UMC)
+				dev_warn(obj->adev->dev, "Poison mode, no need to do page retirement"
+								"in UMC ras handler!\n");
+			else {
+				/* Let IP handle its data, maybe we need get the output
+				 * from the callback to udpate the error type/count, etc
+				 */
+				ret =3D data->cb(obj->adev, &err_data, &entry);
+				/* ue will trigger an interrupt, and in that case
+				 * we need do a reset to recovery the whole system.
+				 * But leave IP do that recovery, here we just dispatch
+				 * the error.
 				 */
-				obj->err_data.ue_count +=3D err_data.ue_count;
-				obj->err_data.ce_count +=3D err_data.ce_count;
+				if (ret =3D=3D AMDGPU_RAS_SUCCESS) {
+					/* these counts could be left as 0 if
+					 * some blocks do not count error number
+					 */
+					obj->err_data.ue_count +=3D err_data.ue_count;
+					obj->err_data.ce_count +=3D err_data.ce_count;
+				}
 			}
 		}
 	}
--
2.17.1

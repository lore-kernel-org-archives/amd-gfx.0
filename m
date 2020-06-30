Return-Path: <SRS0=hrZh=AL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944E3C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 15:26:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35ABB20663
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 15:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SrHrpAKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35ABB20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9F476E32B;
	Tue, 30 Jun 2020 15:26:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF8F6E32B
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2020 15:26:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekm0CW4ptNslUfe07u2Ovlu6umZpjnwmzS/siljKRzvHxeIqDGVi7SYOgyfKIK8RchhM/bxTSzTWh2I0uPl6X0vFh20QUiChBzr2LTmBjjpPWPaaTsSrx6zM8B9/4u97/VXOdnFhMFI1znf13C+pjSXMzf7v3IMcJJzjQTfukGDyJK2epmK1mlqbsFIj83jcYW24OYEhU4MohoqBL4JLCmsPNFPvAL/imYtox5J4lcjLs9wEVNDDXg+VLRw9LGS7vgSdrccNA6SaPIU2xlPbCotBsqNuPzCZ+pYZ6v6VaqMirVVn3uV70Vm6zgcftI9TLvii9FOjjmej3VE2HNJHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozxwLyxR3wgu/9D9i7QPNabnkV8X45DjkJJndYFtSk4=;
 b=j93vKqhLPWANby/J7dmDkQkZtcqcU5lJtzHJRBHduw8Bs0FsfEd930BiOdWn/gpYgwXCh8dfIZkKHgVIdPj37IjUsuNuNTpfY8FTWIflTEwCTGTIynCnKIWhHoshb5IbGdwkoV+n+LiTw/8IGUSe3QR6JqkCks/nR3Nl7ArKdFTjPP9C/HaNt3kyXfO0E6CS16eZaZRFzQEDiCXNcu2GVMeXn/n4gGwicSZLl+tUEe6xwD93/8JF1/nbMXIZN+V808thRqmJpVWhDKMlxu4QcAKiR/ff2dkoODASa5od6+AdvivXtEY2kcZwOY3GsMPneV9QwTczhhEPIuZpdwY/ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozxwLyxR3wgu/9D9i7QPNabnkV8X45DjkJJndYFtSk4=;
 b=SrHrpAKbPxEo6yaCtTnK/gK5n4Kty3j0vgyCqhaUR4wEW85JLwfzZPo6nkP8hUs45XJANXNMpBFXZRS0Ms0lYc8ub/32kpoBWci+GNXmAfdAsDWgjB543thtPHeolTyAuo2KuUN2TS6jr8m54ysPztJaRKN4YPN/oSyz98DRNos=
Received: from BN7PR12MB2801.namprd12.prod.outlook.com (2603:10b6:408:2d::33)
 by BN8PR12MB3217.namprd12.prod.outlook.com (2603:10b6:408:6e::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Tue, 30 Jun
 2020 15:26:35 +0000
Received: from BN7PR12MB2801.namprd12.prod.outlook.com
 ([fe80::f08f:4a05:4ebb:d8da]) by BN7PR12MB2801.namprd12.prod.outlook.com
 ([fe80::f08f:4a05:4ebb:d8da%5]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 15:26:35 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Only revalidate bandwidth on medium and
 fast updates
Thread-Topic: [PATCH] drm/amd/display: Only revalidate bandwidth on medium and
 fast updates
Thread-Index: AQHWTlcBVr6Da3G1QEumfze/0T/YhKjxSEKg
Date: Tue, 30 Jun 2020 15:26:35 +0000
Message-ID: <BN7PR12MB280144B4E496EDE39FBD3E19896F0@BN7PR12MB2801.namprd12.prod.outlook.com>
References: <20200629204924.13426-1-nicholas.kazlauskas@amd.com>
In-Reply-To: <20200629204924.13426-1-nicholas.kazlauskas@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-30T15:26:28Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=20206637-5f6a-46c2-8582-e42d703c1126;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 10d0ed0c-00e4-4240-7a42-08d81d09f9a8
x-ms-traffictypediagnostic: BN8PR12MB3217:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB3217B9E5A2DB39F048B6F91E896F0@BN8PR12MB3217.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:451;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kUcpm5oHjYvRFd3JvzCsj+BVVUd/V+rkxwhktyVmELuo8Mufc+tQTobJ9CX+bxlTumgIdoAtwXboFdv/w9dHFUq+/JMx7r+aMhXuGCXp4Bb8a48Dw5QM8tH03twTRLKa/Q4QQeEwF2yLedEXnnOAIETFrG/4bo+aGPQ/mi0bJvHIbaCKuTuCdWvsc0VcQd6k4b1QX3A1fP9KOwUE1l4+qJyUcovgeuQb1rlvahhWDMnwbnAMVnj3QTSQs49nSkETyFFzqFeGrSjxSMChwW9ryvIKimv0iQe1oG3JyiTinVYZojTkEGP8aPwnM/xZjAc3TYzvC8+zm3DeDpOKBiliPmmbocQTRpyXOBNzIuFvHeg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2801.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(8676002)(6506007)(86362001)(52536014)(45080400002)(76116006)(8936002)(5660300002)(966005)(4326008)(2906002)(53546011)(186003)(26005)(7696005)(33656002)(110136005)(54906003)(15650500001)(316002)(55016002)(478600001)(66946007)(9686003)(83380400001)(66476007)(64756008)(66556008)(66446008)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: TlxBN2vVcAyXWSEv4iDJtLbtKCsreuIyOWxRmpcGEhC+JCQ0gRLPuuOaj4uRDnRlluhJMqxnFlHV1MGJjVnG4dx/MaaGiOiJYPqbdQz64YNx54uYhmNI+Faob6Wbzs/UHzmuySfbxwMDB83KDdKA3z4zuyugqqqOl5W3GQeep4ACM9SNt/GeOFQsC2pkwk/E3M+0FCFXDlCKYFfQb/HkO0cBa1gkNosOVVoE2MfU5tXlohGr5D0uV5zW1Vm/q3cGg6Fd4DIOLSfZnLzOwL2n1Kp46QvwPQiEu6CrBq94IkWoCK6OqQSTXkcAB+IV5+eQLtkZQeRz6khOT/XOv7NhwMIpUihcu2dt4AakrQHLZHd0MYE1gx8BCEHJJ1yC6aIZ9bujYaKvhy8954iBIP0ZoomrY6JmgF0c1PMaJNcoqeE6H7L/Sdj33zLnLdJn8ilUwiKIXTZbjbiNBrP2IowfwXXFg6wfBCAjVYS1ZrMcH+x8+mX2e/fKpdlmtiRwh/9e
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2801.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d0ed0c-00e4-4240-7a42-08d81d09f9a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 15:26:35.2125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DBT4fClFU2lHkslri1MPkExb9LoLo8cYxF4rCWpAlV8iZ//K6jTD3/4XE7Qq/fh2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3217
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
Cc: "Wu, Hersen" <hersenxs.wu@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Kazlauskas, 
 Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Roman Li <Roman.Li@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Nicholas Kazlauskas
Sent: Monday, June 29, 2020 4:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>
Subject: [PATCH] drm/amd/display: Only revalidate bandwidth on medium and fast updates

[Why]
Changes that are fast don't require updating DLG parameters making this call unnecessary. Considering this is an expensive call it should not be done on every flip.

DML touches clocks, p-state support, DLG params and a few other DC internal flags and these aren't expected during fast. A hang has been reported with this change when called on every flip which suggests that modifying these fields is not recommended behavior on fast updates.

[How]
Guard the validation to only happen if update type isn't FAST.

Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1191&amp;data=02%7C01%7Croman.li%40amd.com%7Cc98c2d3c363643a4fef208d81c6dfa68%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637290606647861029&amp;sdata=%2B3rZlvLgef1c2FOYTKx37U%2Fbr%2BWOxI9GXVI2K7HjH3E%3D&amp;reserved=0
Fixes: e1995f0909e3 ("drm/amd/display: Revalidate bandwidth before commiting DC updates")
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 67402d75e67e..942ceb0f6383 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2607,10 +2607,12 @@ void dc_commit_updates_for_stream(struct dc *dc,
 
 	copy_stream_update_to_stream(dc, context, stream, stream_update);
 
-	if (!dc->res_pool->funcs->validate_bandwidth(dc, context, false)) {
-		DC_ERROR("Mode validation failed for stream update!\n");
-		dc_release_state(context);
-		return;
+	if (update_type > UPDATE_TYPE_FAST) {
+		if (!dc->res_pool->funcs->validate_bandwidth(dc, context, false)) {
+			DC_ERROR("Mode validation failed for stream update!\n");
+			dc_release_state(context);
+			return;
+		}
 	}
 
 	commit_planes_for_stream(
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Croman.li%40amd.com%7Cc98c2d3c363643a4fef208d81c6dfa68%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637290606647861029&amp;sdata=EPY6DwDOG88a944QieZj%2F8NSeBJTot2z1WLghTM2Iuw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

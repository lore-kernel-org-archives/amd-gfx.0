Return-Path: <SRS0=8ysN=7Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5E9C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 16:12:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78085205CB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 16:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vSEnQlO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78085205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 289A989B03;
	Wed,  3 Jun 2020 16:12:19 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770054.outbound.protection.outlook.com [40.107.77.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A2B889B03
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2020 16:12:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuEHW3VwhNkabK4am6xXZDSKzDuPVa8+YENEwYb0idDL35OacJdNQBPBWsJ/nMXbc8bKVEM68zKMUTcq1C1X8DWSc1emfia22Adks7vNVoDsGwXxmuzPVsJL4w6mLTUg2q+mTya1fMNZt36sx3PqR/ZJy1S3dVRCBCiMeZc5KKxBOMbzcdfh50ClL29GW3Cn3azgXPvKv+HMVmRZTX9wzZpZXwirZ+a4ynX9yTtrwPvbWmOBIvC8dRLyrxdj9EbSD4SDF+h2fnDDMNW/GXyXeaBCMnKz1l85bKa8vmAE3Guc2tiIvHUcFnsfrAjRq+qUB1Ga0biD1BKrpNB4gqH+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89M27N+plo/9IPl+vqgamhBLAU1m6NdmXg1Pd5LoHho=;
 b=gW+2VnZqgkFUsxmjDb1izCb5ru+XyNJQpTiRbizCu/ggyNW1h3ema8R8uPDR9OQpktkH4AQM9rU7jFyZ+C84hxHdjOyiEuzwlkrNJ98Oy/qEfbs2Z5NLyMe9V8ug+TdFZlHGXwRIV7rEVZNQY4ppysLTdQ+4xZK7HoUKobH7bNVbjN8B/6I3XCiOVpbKqJKLL24wouXTeazyKYo+3D80IM1QuH3n0y19uyqMJq1nAOUTv5Hu5+YlHnpi1PmrrOnl4GCHS0ldhy3igByra6cqkbF2XiYcNrhAPGMmedZ7Jv+qi8X4+2nkhRO5xydKJmIeJULkXJBXeI5wo1+Ta/asDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89M27N+plo/9IPl+vqgamhBLAU1m6NdmXg1Pd5LoHho=;
 b=vSEnQlO1PqTIpqdOb1aCS1hIRweaGq6UWHudw3Dp3G7IGc98j76jGDfIvbPEEDUnvSHWCyCW+O+XKFap6cP5qKIzHx9y+qCmqlBrcGj+PI96kWDjSf9cP6/Ddy8LuEIcwz07JZVnbBqmCJf0d20aeHnBJldN+wj6top1GG07F5I=
Received: from DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 16:12:16 +0000
Received: from DM6PR12MB4156.namprd12.prod.outlook.com
 ([fe80::53:8095:2cd:ef21]) by DM6PR12MB4156.namprd12.prod.outlook.com
 ([fe80::53:8095:2cd:ef21%8]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 16:12:16 +0000
From: "Wu, Hersen" <hersenxs.wu@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Revalidate bandwidth before commiting DC
 updates
Thread-Topic: [PATCH] drm/amd/display: Revalidate bandwidth before commiting
 DC updates
Thread-Index: AQHWOUFwU2JmT3UMr0qLc80lODfBh6jHEENQ
Date: Wed, 3 Jun 2020 16:12:16 +0000
Message-ID: <DM6PR12MB415602C219FC3DF5BBA60CCFFD880@DM6PR12MB4156.namprd12.prod.outlook.com>
References: <20200603005336.32196-1-nicholas.kazlauskas@amd.com>
In-Reply-To: <20200603005336.32196-1-nicholas.kazlauskas@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-03T16:12:06Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=49078a68-9528-4a5b-9e23-0000d08f866a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-06-03T16:12:06Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 9444d1bf-c9f9-43d5-b85f-00002bf98863
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd8f0202-63b9-4590-f6b8-08d807d8e27c
x-ms-traffictypediagnostic: DM6PR12MB4452:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4452C1AE0C66756D844AB41DFD880@DM6PR12MB4452.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aDiFDCGyePE6YrIOuKWwhFWEv//cMtPckAhvPq72kGpld+Zxf17RCrdIWVmWTckxC9BU+5CWbPoNuqE8BZM0O7WhGCttiKyhCwpNJJT+B2og5Px+Y9dh0wJQnZfU8x6e5nrkg2BIw82G/VgCQTIDj4XNOABch/+8S1mRJCu3Su+7noeAN6/X0UC+vig5SYlEe0AkyZlzrCjqP4je66BUPoJaxXNmpGzQ1r87bAkOLTGy51bWz/IgUrLiZBTic1O8WkcmPMEqJrKq18dQWsKKByXTDAmP96S/Ek+bDCJZosNTI/Y+OrU5zF9F58TyQRki
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(33656002)(478600001)(83380400001)(15650500001)(52536014)(5660300002)(8936002)(71200400001)(7696005)(8676002)(2906002)(110136005)(76116006)(26005)(53546011)(9686003)(86362001)(186003)(64756008)(54906003)(66476007)(66446008)(66556008)(55016002)(316002)(66946007)(6506007)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: gDKnXy41A6UrmDjlFAMxA5nqBRtqb58g9Z0yI5HE5XTb6DO/UHpDTdiiLbihNLRCHV98fQa8ukFr2XzUAlLDqTpMYFUDuBuq6mnR3fm8yj3Fjf69LiVVhlsnYlVQuVv6YovmppDFMg5ZA9RVCYnlpSGbnRRJXGryTUzOKr9f1BtXmKjfH/q0M4KoMm6BF9gA4Kgcd4s7EtUF2aEzbxiq5DRRyFdOfVvajdtZKASZ0nA54leinYMRiKhIz2g5CszAm7WRDpduiK8PKGCumpaytInU5TJbOeVfyEXIQZ6azR59UgQx+NZ0F7HTvNCSgFL3BIwWg1N1c3UTUFUQcEtlJoqZsRgYg92WChbpY44FF4a9ZbEmdA0oD5Gzu+REcJaKpKF+deCbS9d1ZmU72W/xWwt3tx0lUW3KNTlq68Zxl6VpZ5K9uqecKZKPAMjTLND92sN0JHuOVhMeh31FLMniQ75Vs+uc1rAlyhJ1yZRSjO7KmNtTFBCWeXNSchz68uBf
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8f0202-63b9-4590-f6b8-08d807d8e27c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 16:12:16.5911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nAjwT/gcsi27jC0cVdLWbQJMuDvXh69wlqAoz5tCUQlM2zy8nKif1uXMNxfqQ/z5d0JgK+W35SZ/3UB8qVoyag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

As workaround, the patch looks good.
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>

-----Original Message-----
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com> 
Sent: Tuesday, June 2, 2020 8:54 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>
Subject: [PATCH] drm/amd/display: Revalidate bandwidth before commiting DC updates

[Why]
Whenever we switch between tiled formats without also switching pixel formats or doing anything else that recreates the DC plane state we can run into underflow or hangs since we're not updating the DML parameters before committing to the hardware.

[How]
If the update type is FULL then call validate_bandwidth again to update the DML parmeters before committing the state.

This is basically just a workaround and protective measure against update types being added DC where we could run into this issue in the future.

We can only fully validate the state in advance before applying it to the hardware if we recreate all the plane and stream states since we can't modify what's currently in use.

The next step is to update DM to ensure that we're creating the plane and stream states for whatever could potentially be a full update in DC to pre-emptively recreate the state for DC global validation.

The workaround can stay until this has been fixed in DM.

Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 04c3d9f7e323..00a4f679759f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2523,6 +2523,12 @@ void dc_commit_updates_for_stream(struct dc *dc,
 
 	copy_stream_update_to_stream(dc, context, stream, stream_update);
 
+	if (!dc->res_pool->funcs->validate_bandwidth(dc, context, false)) {
+		DC_ERROR("Mode validation failed for stream update!\n");
+		dc_release_state(context);
+		return;
+	}
+
 	commit_planes_for_stream(
 				dc,
 				srf_updates,
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

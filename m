Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E94C4332B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 21:21:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5055D20772
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 21:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tNHdQnmN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5055D20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E46206E23B;
	Wed, 18 Mar 2020 21:21:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D86DB6E23B
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 21:21:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2Vk1tEHJF/5uv4KlHG69yd7Sd9wPn3dZL/9bnexEDqsDyu7HkGc+Ty0q2V7FGgeUQxPkU7pwT8D77uPHHc0BKzVqhxYNX5/uZDsXlxHYpITQmrLzwZufboGsv0V4qBGwZgxjVB6kg42SasGPgoGoEuAPyxqgw/B6AGuai0IAHgMyH0UgWi7lTDL81ivLE6zY2V52AFb+B/rqs/cMK0RbebN1MZXIjT3/6Mq8QqpT6+rTSK3fFACBhvOOkh/RfyaFnGF22J0ciBOfAFT1oqnqpuECVzHjQfoq5kCK6DrohMNx0jXmiyRTbq/mwfRYpQcFFcnXQkSYo90jG6MSGmOjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YayD/z0PRS1PPG4uqgA7BENBw30iII7Lva5nVBmXizk=;
 b=fUweLBZi4Zv0pd/GrQGATSl82+gkp57hPPHJD3zGg9uPAH4T/g5dhKPswFHYjMgP+bmbsiNpuBvqAisHwboCvjkAKnRHt5tm6DZzCOevLF16akQmNEd9UsISMp3Sv67u+a2PdzgQXhApXrJnnK5TztstJoBPf049aUkPr9JEwdlX+HIlfnWRRAcMkb2jGUqF+ETm3j766ggtYwgVbso5GicPlNW2tvDSpBfSfkFE6QkYS4uD8ov4T96ZiInGg6w7OpFBw3SM3PjWDBmXSQnZmWIbwJ7llLIj8XvbaA4miDQmnIsyO48oWXzZ/tUxsnKFrXh6o6pHz5kEudTqwmGFTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YayD/z0PRS1PPG4uqgA7BENBw30iII7Lva5nVBmXizk=;
 b=tNHdQnmNW4HRZ9BTJeCjC05uDrLrqYL572I4/525GtRMMXEcKu3DvxOWdX81anozByO8UUNbrNLZjAf8xxHj9u5AsT28xHSZRP4+B8bChVP5DAt16RgtVoipkzwf+08D+WdNkjMS30qpv5wx2IekuI+KVBfdQTJ+JupaMglpF5c=
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (2603:10b6:5:1c9::32)
 by DM6PR12MB3850.namprd12.prod.outlook.com (2603:10b6:5:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Wed, 18 Mar
 2020 21:21:56 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686%6]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 21:21:56 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amdgpu: fix typo for vcn1 idle check
Thread-Topic: [PATCH 1/3] drm/amdgpu: fix typo for vcn1 idle check
Thread-Index: AQHV/Wpx+1eg+v8lhkWINPw8zYP646hO22pQ
Date: Wed, 18 Mar 2020 21:21:56 +0000
Message-ID: <DM6PR12MB39144AA6E4F486290E277548E5F70@DM6PR12MB3914.namprd12.prod.outlook.com>
References: <1584566084-23428-1-git-send-email-James.Zhu@amd.com>
In-Reply-To: <1584566084-23428-1-git-send-email-James.Zhu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
x-originating-ip: [99.244.66.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b63f628c-5a01-4d8d-584b-08d7cb826324
x-ms-traffictypediagnostic: DM6PR12MB3850:|DM6PR12MB3850:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3850CDBE93F270C20B082207E5F70@DM6PR12MB3850.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(199004)(316002)(76116006)(6506007)(7696005)(45080400002)(9686003)(966005)(53546011)(478600001)(55016002)(4326008)(8936002)(33656002)(64756008)(66446008)(66476007)(66556008)(5660300002)(52536014)(66946007)(86362001)(71200400001)(26005)(81166006)(186003)(8676002)(2906002)(110136005)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3850;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CFotuOy+E4UAumRS6hPXlPLI/qFIXQobPoRlSm/xig1g/t9dprwS8IZC97cOgn+rqcTM6+YHfGDlGFkKRd5N0jdJz0/iRvHjC/6Kc4XdlTJclBcKSwiorIWd2d67QPl87EtFsZsdXAfZzAxSKfn+8DCDyMkQ9NyL3cQHQlc320MtG0IH4x83VkXMWnMH0f6rdJJFMH8nSWnvxmzNcExV4n2nD9uzTleFvrGM0AuiaPg7d6DnL316xdCZc4JJ4+L7kQo3cKBCU9p7VxCVHo12xNCbKzDFj4bUeSFCaciHFKeCEWbFIWCVBny6IcoEc9I5ViXx/07YjKVFm9cGgtkbBFc8NghRBAYXfE3B45JLWpc5IPj8tiGOMl5l7vTYCiwBA5nmpNvcNyPRiOMd03M6Ql7ctqgn7Qb5koPldQevcdKrxSnV1BPpGTXFuy6dh8xp/Tq2dckk8L8OF5Iz7nWMnlSzL0TGa3V1R/XxWitvvS8=
x-ms-exchange-antispam-messagedata: eAOggkBiWOTyVhzT8y3J3BBFtgO6/L+LoW8eN5PXRpjYI6LdTcgVZo34WqhmfhDTudY5rG3TxDjKDRJAw+ES97tyyYZbvHbEnTio6nZlNwbUrdiPkG07h0l5vRGCJ3LnZ0VzZj6k/SR3hhT4L7FreA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b63f628c-5a01-4d8d-584b-08d7cb826324
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 21:21:56.4838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dd2Dgdwy3kyCXA836rapFM4G10nSKRJ0m8D/sz0SvsyZGumQ8K+mc42P4gEfxYvW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3850
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
Cc: "Zhu, James" <James.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series are:
Reviewed-by: Leo Liu <leo.liu@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of James Zhu
Sent: March 18, 2020 5:15 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhu, James <James.Zhu@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: fix typo for vcn1 idle check

fix typo for vcn1 idle check

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 71f61af..09b0572 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1352,7 +1352,7 @@ static int vcn_v1_0_set_clockgating_state(void *handle,
 
 	if (enable) {
 		/* wait for STATUS to clear */
-		if (vcn_v1_0_is_idle(handle))
+		if (!vcn_v1_0_is_idle(handle))
 			return -EBUSY;
 		vcn_v1_0_enable_clock_gating(adev);
 	} else {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cleo.liu%40amd.com%7Cb4671aafc2c84b32912108d7cb816c13%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637201629681247323&amp;sdata=mFHBsrSzQN0dQA8DXBGDEpUTsMh%2BvR7Ncz76RsREPX0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

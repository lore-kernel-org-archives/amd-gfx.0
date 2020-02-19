Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B697C34022
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 06:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C42D9208C4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 06:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2GvI1Nw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42D9208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E9E16EB16;
	Wed, 19 Feb 2020 06:26:10 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680080.outbound.protection.outlook.com [40.107.68.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 326936EB16
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 06:26:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQBVQz+S85ZemjjOHVoMERvw9Qs5bmFoX8gcKw90ov1YKG5x8ElLYiK1MieQezl5+YeuR/2kxWaK5Hs3d5gA2UY8jpM80CnZph9uZyZUSM0HylduwUMBgKg49/W8OaH433lzwzpcNEKq13/JDlL+G3WGxKFc/SpQaPEa4BCftiAXXJatOSuD/nOtOwdDwJ+bPpDT6LSGr1TFdkNuNA8tEF4uRvcZ7HRcKAUrh4U8reN8Lg9fbXBEguwZUE20DtclUIuirt4mJSV6niBQLUcC8yfEH5AbVRz50Zdh74/gl3mJwP+anW/0aT/ch5wl05a6dcNtKgRrZX7G4DlqlWuuFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyZBVdgGVgDBTke3UVh5JUQic+Sozbb5vhG4Tac5bcs=;
 b=j1MWC0Nvc+w5dlWUwkeSth+tbkd/x/ovLEb+rqzUzCgo3Wr2cO+iVyTsGqoP45yz9rwiQZtg6eTcqJIH0a1nKesgDxUWtcPi9cwX7QvmrjV8PybBBzm1ab27dQChpSuEmaYOIALE6zGk97ZPnzmAY7h/dHFSEZJBHma1VC9EyNroTrnLGhiGrIINOXZP/ctjmqgY3I3F9ztmH6ZOLuwbHSYy/3QJrylbRz8cEGjaypD+5hjBIP+8yq83xg+Mo3tf+9aFUe3UdqGOvfAlvvjYLbcWgWME4vHViYRozHVrv5vLrCYmt9vIsaK7P4IzYDUfSfnQnQ4iGd8PCYpGeuN4ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyZBVdgGVgDBTke3UVh5JUQic+Sozbb5vhG4Tac5bcs=;
 b=2GvI1Nw+y/w5Qfcl0kXjRctO9AxZt9HMHlE9hk1STB7elsLQ2+1yRcMpGN6q9Z/bQTSfB8L1PTbJyApnfxuuCDSnI522gTZ0WUZUdEeAIqWt8QlavBHHnVnY2YTLpYT0El1R4D6wnCQwo4cu2bftu1UmMADgkZzwJrHhVJC0qRw=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1180.namprd12.prod.outlook.com (10.168.237.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.29; Wed, 19 Feb 2020 06:26:06 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 06:26:06 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix a bug NULL pointer dereference
Thread-Topic: [PATCH] drm/amdgpu: fix a bug NULL pointer dereference
Thread-Index: AQHV5tnDNJpnogbMukOLAzHTaDtGf6giDQQg
Date: Wed, 19 Feb 2020 06:26:06 +0000
Message-ID: <DM5PR12MB1418062D884DBE08E1FB9997FC100@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20200219040445.11112-1-Dennis.Li@amd.com>
In-Reply-To: <20200219040445.11112-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-19T06:26:03Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1a5b6f21-d394-419c-8090-0000f616def0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-19T06:26:03Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 9044cdd9-7e1b-4404-9075-000007eecddc
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d2858034-a63c-4138-5b20-08d7b5049a26
x-ms-traffictypediagnostic: DM5PR12MB1180:|DM5PR12MB1180:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1180E35CFF27C7F68C9CB4B5FC100@DM5PR12MB1180.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:154;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(199004)(189003)(6636002)(5660300002)(186003)(71200400001)(8676002)(2906002)(66946007)(76116006)(52536014)(4326008)(6506007)(478600001)(86362001)(81166006)(53546011)(26005)(81156014)(110136005)(33656002)(8936002)(7696005)(316002)(66476007)(64756008)(66446008)(66556008)(9686003)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1180;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v47TThyiSstszzzEEf0EMx+kLJMzOUkGeDmQ00qwKtDt+hfaENQt3LiXJUuFAq103kHBibjO3se5nBqn2DChUWzmcVsCAv/gpvhMAd8aS5kk0gPn9IfwQRdIz9koSCj5oaE7AcEeNVV3BGTgvtiOZDn2VbbGd2Rb5PklddDFE3nuw7Cl+SUfVySWc0jZp8dAMLGzg6OLrXWM+mHBVfr8swF/jBNG4FUa5bTaOPjpLGceA5LeOk0UprSY6QwSpsuG3GhSihfpRS+OoOsK7fIpJcjnE6NFyhykoViEiEnUutJcar+uF8GK1dXjqppYj0r8d3fgOCFXJFRi5OmJ1i1MHp7KQDSOwDARnb5b/e9M4Hn4UGER7OYUO3sgfRBo4gaiIlXmmOc5UOF6+L4ryvyjpOIj9zd7eqiYt6lGnh1VXL9skYbjRQzJnD9lTFib/fd6
x-ms-exchange-antispam-messagedata: 9fW8WqN5c+1gQx3PQ2pOB3XqxcVnb3kPw6B0Du/l6gS60zBnsppy0kzuztf5cSTA8Uj2F9PHZwzCWduaevFdf4j1l1rn8QCrLX3DRKzpaBX/Lxu+8dlRAJLldTcbbCwMTWp3236ib2lomLk8kZ9UJQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2858034-a63c-4138-5b20-08d7b5049a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 06:26:06.5696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lTjUId98iy58pdTPyWUDeXswEG50gJsM9QNN10vqD5hSwJ6TruQk5mC+lFdqAuHKx9I6TR97h9YyJQm9LmRIQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1180
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Wednesday, February 19, 2020 12:05
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: fix a bug NULL pointer dereference

check whether the queue of entity is null to avoid null pointer dereference.

Change-Id: I08d56774012cf229ba2fe7a011c1359e8d1e2781
Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 4cc7881f438c..67cca463ddcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -95,6 +95,9 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
 	int r;
 
 	entity = p->direct ? &p->vm->direct : &p->vm->delayed;
+	if (!entity->rq)
+		return 0;
+
 	ring = container_of(entity->rq->sched, struct amdgpu_ring, sched);
 
 	WARN_ON(ib->length_dw == 0);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

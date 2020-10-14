Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36028C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 10:07:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8375F2068E
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 10:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DfnvuuvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8375F2068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BB026E429;
	Wed, 14 Oct 2020 10:07:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FF526E429
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 10:07:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CG9tO6jIUlaMt/CIV8mEqdy2CAjsMuB2GHU4DauE5hov/4sofyuxaIY6dvjiFXpR3elN4/+fhouQMiuSjsOrOJx/oV44V7wAs93v1GyqpofPETE/qW/41kgSpx4rfkVS4KqzAk6xsQuLyoZT3GAmA0u4+dITbCXouhmeKRqYMFFRu5/oU9oV3kyZsFvS89UBTYPUC30zws1zE5ciHq1Jtp4OArOjBHCFApRJPS8/GsqTimm1TfC/XR4AeUMuiD2KIGWWWKp4Wytnt/V6MGPQWAsquQnEJl4pGzbvcLSCU8wKAh3OHK64wYTkPBWUZlHGn1sla2DBhlbutu3ScSjWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rPuwFFOCzYl9NVckqhOqo6DnCsSYM5aZS8EIqHVMWs=;
 b=Aq8V4VR4QbWxe9s7x0tthYgH/KNJZiuyi023LZDwB38H6ifpGU0SMajj65kDllhvNCIwOeAQwa6YuWn6NEQ+zBpwZKHiXlC19QYRmO1IHb0Bgf18sK2E6AhZseAIgMzvwuJr/6FYrvsJtkTHuf3yazfDMOq4L76YaudpG3mLkCaBnlxpsni1JfNjMqCnZB9eNNBYDF5lwJqMNXUIr9S4bwnY24zZ2/xwZC6lk5r7KP5nR5i41CMD2hGBfvEC1XldOiccQInfmUT4SYVHVLgKO+e39Gu4Dn0S0UhRd8A8N9JlmvlHgu092SapPCEqR4TUw30Tt9SPCYDGQghYrpgenw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rPuwFFOCzYl9NVckqhOqo6DnCsSYM5aZS8EIqHVMWs=;
 b=DfnvuuvN6T6MO1/x3wPX7LtL4FNC/kLy+BPLa3NV7ojx7u5aRv7yvf+v3cswJvOwnyVoHEXr1OuFhgGx7kv36AcqIrkpmO7UT2ZFq17skO1IHHpWebWdBsT2I7FXaQ9+2B0f5hSU23kj81GdKAAaft6r959NUS8UPvLuNpc+feU=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM6PR12MB3195.namprd12.prod.outlook.com (2603:10b6:5:183::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23; Wed, 14 Oct 2020 10:07:31 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::e93d:552b:9827:da51]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::e93d:552b:9827:da51%7]) with mapi id 15.20.3455.032; Wed, 14 Oct 2020
 10:07:31 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: protect eeprom update from GPU reset
Thread-Topic: [PATCH] drm/amdgpu: protect eeprom update from GPU reset
Thread-Index: AQHWog4XNvObGmeQxkOOfmHs0n6DHqmW2xsAgAADHMA=
Date: Wed, 14 Oct 2020 10:07:31 +0000
Message-ID: <DM5PR12MB253373BD9752583C364FB7A9ED050@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20201014094031.22448-1-Dennis.Li@amd.com>
 <DM6PR12MB4075AC679F9E58AEBDD7F211FC050@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4075AC679F9E58AEBDD7F211FC050@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-14T09:51:33Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c89e326c-9e72-4b26-aed5-0000f972b55a;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53e62598-9c35-44ba-a185-08d87028f6b2
x-ms-traffictypediagnostic: DM6PR12MB3195:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3195C275354E0CDE3F482C2AED050@DM6PR12MB3195.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QDloTIWcAREtITQIw0jaOuXEUNImpm0Hwslyfdr4qmH86XtIDOKGIeUMcFxzphu0Nf0BigSFKmgvWYfZG+97OUpBrq7o6n+JvXkt4It8xK0uhimVX6Z+52LMwXqiTOVFil0gGWEPaQ/K/aWsY9pfd47cE/XgLp9PDqjQAXOOk8dZpmJpzCzEdDHwgm5e1b6L2PBc2ick9zNLjBiUQfEe8ZzGu5pC9SVqMhOGgB4Kigc9elBE7X6jmBqB41zhPeQ3rV2zomOCBzncv3smznCj1eUvpqEI+TtThQdEv9xU5eClCOhg7/DgVJiIv9cEaxaE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(55016002)(66946007)(186003)(478600001)(8676002)(33656002)(86362001)(5660300002)(6636002)(7696005)(71200400001)(52536014)(110136005)(26005)(316002)(53546011)(6506007)(9686003)(64756008)(66446008)(66556008)(15650500001)(66476007)(8936002)(76116006)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: vTlw9wa7HAPm5gFS8npBxF8VCvU130xxrwv/bbjvbwCCjigYtpbA8HNN1tjMYVMnfYEsAj9zco4gfSxtQlGlN8MY5d2XZnpAwPHA6rL3VK4BumMHTwjyIjIYzHJqz7zpyQl9++fI6ZvtzEDX2BnC/Vmfw6eIcXIkTKnDvILE8CUrELQy75OeTDmUeVdn5DVTdYnyKZ4x/MJLTYlJXTNYmVE25gZ+2VmGf0pjtr1oCIwvpcgqrcVKIxAc2kMn9yTFjxZ63p0QvaoplpzxZKdptZqLdkRDA+0D1A88r+TLuWaGMvNE72bu3fXI2Vc207EDWfV91A7Vyz3yKq/0NrbTNFcNKfKzAErb9J73FHy5wxdW2PSjjerI6R0424naytPqts/6wwOUdpupSnwh3KKHyY7Ke2wI36pt/1meam+OCTcjCr5FaN8fQlLAGmScYzHW/T6YgL+Ke6yrvigkJf14y4MxaFSRC8W7IKhp8pe47w0hIMDiNqQ7UqaASLO1IFwaIw5ejQmR9w5EDNPr8DgpGqBwGbsRHuwOn4wbfNZDESW6XRJ7vRdwsaJ59xTze1LHakPFfar1pwEhLU+jdqDJNr0HP6B/YIuD4lZlGrAkA9A6FRDLei/N+9qWXbUt7aJjG1Omm0cUf8keC5A0KByZXA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e62598-9c35-44ba-a185-08d87028f6b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 10:07:31.0591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rOlRFmMOZ7k4z3zdEo/fazZn3tEyL39cGVSrFvXpz6HH/rrCutfkZvhIUb1aEC1y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3195
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi, Hawking,
      Driver has multi-path into GPU reset, so driver couldn't guarantee that bad record update has been done before GPU reset. 

Best Regards
Dennis Li
-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Wednesday, October 14, 2020 5:52 PM
To: Li, Dennis <Dennis.Li@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: protect eeprom update from GPU reset

[AMD Public Use]

Hmm, I think bad page record update is done ahead of scheduling gpu reset work. For mGPU case, shall we walk through all the nodes in a hive before issue gpu reset work?

Regards,
Hawking

-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Wednesday, October 14, 2020 17:41
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: protect eeprom update from GPU reset

because i2c is unstable in GPU reset, driver need protect eeprom update from GPU reset, to not miss any bad page record.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 0e64c39a2372..695bcfc5c983 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -149,7 +149,11 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
 
 	msg.addr = control->i2c_address;
 
+	/* i2c may be unstable in gpu reset */
+	down_read(&adev->reset_sem);
 	ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
+	up_read(&adev->reset_sem);
+
 	if (ret < 1)
 		DRM_ERROR("Failed to write EEPROM table header, ret:%d", ret);
 
@@ -557,7 +561,11 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 		control->next_addr += EEPROM_TABLE_RECORD_SIZE;
 	}
 
+	/* i2c may be unstable in gpu reset */
+	down_read(&adev->reset_sem);
 	ret = i2c_transfer(&adev->pm.smu_i2c, msgs, num);
+	up_read(&adev->reset_sem);
+
 	if (ret < 1) {
 		DRM_ERROR("Failed to process EEPROM table records, ret:%d", ret);
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

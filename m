Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C0AC433E7
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 11:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A052072D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 11:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gczDUvjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A052072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CFBA6EA58;
	Wed, 14 Oct 2020 11:44:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F9BE6EA58
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 11:44:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbBj70O+LjJ295KAP6Uh7WlA3J/LOQvJBmV68J0C/M8ern+0/wmImeaj881Ja9AuHs13/AF8Zh4iHIH8dZQIty47wlbRJPtppURxCznlPWnskmsIIjXWgIlAQnfWB1sdYqru3JMCtfz8SbCWND1M/nqpsYy9rDB4SohfqG3aglHpNEZ2JQAEFLDP5rxnWyYzchlEpEqFxZnHScSrdh8mhG6kE+Vdd9q8K81MQONRD8+VA+HYETPXQWQlyplfXJSMBPeI5bcPeEzfG6+8cwzh+uU3tTkPgANFgDHW5Cv4/5PZF66d9DcjBrpb6CQ9EDTs9UyEzaTA5SFB47bG+VARRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rDPWTYklW9x7usTpJMymA5dEProLfh28RgrIES+T/E=;
 b=PPfcFy8E73AEwJtLOnGqDGm4WQckrd+wWPsBcBMpP+CN4H09JPkFJznDYtrKSucr02jdey1n8SC0arwVZ0ysP3ZvFghudYVRMFp2cdHbfJyDuRFlLZW2fbspxsibgsJfNeOchruSfdVaY2OT4MX+LqWedE2CVLdoV6CwV9cRqJyWb0u5KHd4/0ATm+VzEHSzrSbI1svsCGsB6UrvZB3S7xSmh2jBDePS9W0IabBcM/yXKx6k2nXzsD5LPzLewirEFAmLmbUAaiD7Kvaq1nSrn4tATwHayWQE+RDQFxSnE3CwRiCAmh+G3MjcYEA4raPdDcE1Sgrzhl+/v6n7veACZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rDPWTYklW9x7usTpJMymA5dEProLfh28RgrIES+T/E=;
 b=gczDUvjghNj6oOpRdHrledHckJ0Y0yEbD3VpzwTWJmXB3d7LniuqO+ErA0UKgZ7Hk9uLgpUxgl+Q9DHo3NVUFm5jXv5jT7tNnhWWovxLOIu8GFJK9iikXfe3oTUVxxLhibkWK7YbXwYVPkmzZkbO7yn9GFCTetWX/f/ZhXMWV7k=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21; Wed, 14 Oct 2020 11:44:12 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3477.021; Wed, 14 Oct 2020
 11:44:12 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: protect eeprom update from GPU reset
Thread-Topic: [PATCH] drm/amdgpu: protect eeprom update from GPU reset
Thread-Index: AQHWog4Xt+9c3dBTtUW0gqTw8uzmsKmW2ZSwgAAF94CAABqHEA==
Date: Wed, 14 Oct 2020 11:44:12 +0000
Message-ID: <DM6PR12MB40753F2E51102A9BB82AAF29FC050@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201014094031.22448-1-Dennis.Li@amd.com>
 <DM6PR12MB4075AC679F9E58AEBDD7F211FC050@DM6PR12MB4075.namprd12.prod.outlook.com>
 <DM5PR12MB253373BD9752583C364FB7A9ED050@DM5PR12MB2533.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB253373BD9752583C364FB7A9ED050@DM5PR12MB2533.namprd12.prod.outlook.com>
Accept-Language: en-US
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
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-14T11:44:10Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 175a74a5-ed5b-4023-8083-0000e409114a
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fdcd9ef4-fd51-4f88-e770-08d8703678ba
x-ms-traffictypediagnostic: DM6PR12MB3370:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB33707A2A9F45B3608200CAF3FC050@DM6PR12MB3370.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a/Dr3MeT1OibJ6vcJaVPlYnlrozCt15xEClutefDB0f4z8c5cBPfFHdgeO+OpU07yIkT0/in5yQ5IM2n/No1Z/iF36u/YJlle2j9aCwue6pcnBKnJKcfQDUfYGi6PyQkxA1flYRMUKp2ioAiOfoh1HzIpSG1EqXxCwv7Oqy/WZ8trBA4eJFpQ+Dx7uKbgjoibnqWQVlnKoZ/4eEyrjHIcnXweUQeqHE/63duRRytvs8nUpYHk4CJPxslvkZgQlPEBr1ApcuiMXc4blfujUAoSFtTZD0bHufYZq5FKJrDzcOcsEqe0egRDgJdZiWd3QvV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(6506007)(110136005)(71200400001)(186003)(7696005)(316002)(8676002)(76116006)(64756008)(66446008)(66556008)(66476007)(26005)(66946007)(8936002)(33656002)(83380400001)(53546011)(6636002)(478600001)(2906002)(5660300002)(15650500001)(9686003)(86362001)(52536014)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: mYF1M8HCTJ2GfethXkuppheFjqcWm99Y3LGu5dsGbN6pnfG5zhyKuhn0tmVk8uQrzugL9BJfWq/kQZtQiAyrwJpTRTF2ggn0hxlvbBtqAYUk0yiYApVpgPNkAR5wylebEyUoIzZPJi3EIES/IuxZ017Kq/6rLP2ZeVePoG5vzbIC/dFFNneFvmpKJcBPsVRduNIDGAM4ZKFKYFSVYJF7LmBHM2ZIIRCYqNDBk88rOa8/sFWyet3BUO7tuw94TMobq+sRmIp7A/3hxt9lSXeQrPgFnYIfVeuc4DkQv6cywbxe6B04xtNlPYdKwhS8Y3JLEknG6rlXdTjKibXx6e7/kpV7IknK4ZDzqb3CXAdxy650kFq7IXT+AATvp7iySn0Ft3N0I/yBSuZQh5uIn+r9blBF1F0hWZf8vK6Nh9lUlG7dydWQh4kShM5k2jIE5gcXH6eICPiPm7vD5QwQa0bgZdzmIIhA/pHu0+fHczNc+CG2mpaAMmPkM2LV3UwphEX8CfadDb2vk/1EZqkvtSgliQ3p5Nv19TXIh2ElxlKvlzfuSdUG7nE6DiYmsXDkz3P93l570YCleX9WNSnGkoNBRuBR7vzgQcBtrwyJXZZOFPqfgZ/uAs6mw9vSMoGU9f+fWzUg8LjzxSXft5Jn79H6zA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcd9ef4-fd51-4f88-e770-08d8703678ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 11:44:12.7665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F52wEgmJD7qjzT0EyVKAkcXzEhPojkLV1GfKDjFb9kLRj8Xc+QzNYHBaOdD/YM1f8A8s8cLLOtHRgkqgMAkHQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3370
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

Thanks for the clarifying, Dennis. So this is kind of race condition between normal GPU reset and ras GPU reset. I 'm fine with the change. The patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Li, Dennis <Dennis.Li@amd.com> 
Sent: Wednesday, October 14, 2020 18:08
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: protect eeprom update from GPU reset

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

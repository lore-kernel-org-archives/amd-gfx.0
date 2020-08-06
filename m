Return-Path: <SRS0=X6dN=BQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7863EC433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 01:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49957206B6
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 01:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LiMCfvXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49957206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6C936E10E;
	Thu,  6 Aug 2020 01:44:57 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770059.outbound.protection.outlook.com [40.107.77.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5657A6E10C
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2020 01:44:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtZk63mzhd2rGh6L+oFAVF+j+rSZfV8Scf4bYFn/qwyLBOr+6kRl4Vj13HvUuhhXqeyD+mWHCzNQocXixFOLApWMQuRHKpvPgaDWc5vLksK7nglDNpKmE1aFqvf9tk2Z2rq1ht4665UIBvXtnYAyR1ACoNL8UGb+qwpDr1hQ5btnB314e0C9cdr14iy1+AC4JNvRHzgZZwui+CLH9bvFD2XZtX5qTt/oWKNDDTa8UtmV55Ndtn1j4GV0uEB5UeDf4lcXcc6qgvWJ4VbXbzKUEzTY69gEMTXUX6r2xeqZ3eYWcZscefD19WoBN2wL8tXwmBhbG2Fe6hcYH8nS07z+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgiaAsvFUB+R7O5UVX7BX0Htr588rGBbRULoBVwNomo=;
 b=NZiyygMJTh8FU9GV1gt11DbgpDYS1WRpTJ+28KvOxQ5Rg1zGhulwh1SLOwlJMsoeKwArUWNanbGdb04+NcaGJWSKRf0RYAus72QLOiVzewGBz4vWj+spOuj6gztydiwAcjRhIdzWVruQ0MjAG8yTWB2ycZurXzxWPsS3DVkwrUqsGjjd3sormmuKpGaGatyzEoHcmubsPi/nU3uq0xCb08Xdr4UKvnt1VoY3C7N+BS1hdG6+ZYJEIThj6zw9UjioYZq9/5mG9B4Ix889UcMmyOFKnhojag/4i3ZZlXN8uxdV3DQ19gubKyTgIr1szRdcUZhB4tJIt6jUZuSAaMX8lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgiaAsvFUB+R7O5UVX7BX0Htr588rGBbRULoBVwNomo=;
 b=LiMCfvXhZCpDsar9wRuun1RinhKXryLde9ahsufI/37rKecDJJiU0iPcj6Q/MqXxszXCRuENTMsPlZOnWOyeHr+WglXDaofR1BajHUcpmvj/Wbtsj0LBE7JeL6Xj0Vb8T8G+eM8qxBn4J9aJrUQUFLp5qi9AaFs5JpHY+6bsrnQ=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (10.168.168.136) by
 CY4PR1201MB0118.namprd12.prod.outlook.com (10.174.52.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.20; Thu, 6 Aug 2020 01:44:50 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2%9]) with mapi id 15.20.3239.022; Thu, 6 Aug 2020
 01:44:50 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: unlock mutex on error
Thread-Topic: [PATCH] drm/amdgpu: unlock mutex on error
Thread-Index: AQHWawRLs5zgk+OS3EuHxAACwx9U76kpP76A
Date: Thu, 6 Aug 2020 01:44:50 +0000
Message-ID: <CY4PR12MB12873F215930B31DFB85B451F1480@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200805084146.25788-1-Dennis.Li@amd.com>
In-Reply-To: <20200805084146.25788-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-05T09:34:19Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=96cc0eca-9dcb-4896-b806-0000a1bf8e09;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-06T01:44:49Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: ea72e66a-0929-4c18-bc56-0000b907fb04
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5055aeb9-472c-4186-a312-08d839aa4ef9
x-ms-traffictypediagnostic: CY4PR1201MB0118:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0118505ADB939A9B1E65F610F1480@CY4PR1201MB0118.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:773;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wamZD7FNtAW3qbSh4GyjlcF22o/ErzJergVVwsx9OEsDxZn2mPuZijmaLVF15Rb5GXmrEZVGzMBtiAZTNd3IikxqMa5Te3Jx1Q+6oMRK4WHEFjTPv8nS2y15nmJjwwUARN0KbcGoU1mWYcxxu3kThqiBvZ+nHtBhMg2F6XwOQa4smHkb2Mrt1dTnOBQYm3iMac6B4qIyKEpdLX2kRp5Tk/OQWkvsFRvFX8icafIOEc53LmUgH0k98ugUduM98nIdLkasvOhfwJzgn6Cs1dAHvW6YrjGbieKepzy5YeNnxJUDsjfGC2LI0eluKZ3KDGqoxtFejVBBXw5B6AspnQQ+Bw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(52536014)(76116006)(9686003)(26005)(64756008)(55016002)(66946007)(66476007)(66556008)(66446008)(8676002)(8936002)(2906002)(186003)(4326008)(33656002)(53546011)(5660300002)(316002)(478600001)(6636002)(86362001)(83380400001)(7696005)(6506007)(110136005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 3PfAt3YAn0Dd+FG6SpdAVFAW8VZJtTU78l9dWeM2HyPyVHtXjcVeEzZmysv1cr4a2r/Ul0z5Bvzbj+bM69zK7n/kbtRlqtf21bDfmirA+nXabnIdZKkl+XbzrxqyHSG/QSrIrNCm5ywcvpxIdcw2EJL1rZz7NFaJu3Y6nPsU5RNjjmg0Y8q3tScb1JJb9Dt6ycuKPS+XI0m0kA6PkJlQH2NXyugjqTnN3z20IUJKxKqy1AT314SuqZfnfad2W7sqvMAWA8IKDCTHTvs6Ds0ltkk8fYpSjefJl38ChpqkvjUfD7EY23RNBts8zYvOVP7gLUAmU51UbfQNlNCxzMxkto1v7J3paErTgouLFRusFfGa8kSTfK0pnW5uaJDrKSO0cZ2hs7ZmZCB5JM6cElnoUIIG0l4n0EAUpS8NxKZUfDzQb4wlIYt0ZWbUOzVieuAycI/PDnRXTboRFYeYSJQsDkXDL/pAFGGgHfWQMSp+/ACBEnG9dMeDiPbJ72AeW7TtOoP/WU4YnF/UFIVOWqQZ0qFRiytweuZwRNbpmrjCmLoUg6qoHJNxWDFQYxwYY8Xe7V+MGDEqpOxafGchr7WMANAEsEUA4EejDa5t/aWfe4o3MfLzFqtZrJUM+j5p6LUzpp1dfHGdbQEN/JlaEfOpLw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5055aeb9-472c-4186-a312-08d839aa4ef9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 01:44:50.3532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YT784U6aKWhj4UkT81WWny1hmsYWoyhY36vFaFWotpJGaMlTqUUZqjvDtH+HH5pKSFD3orpyT3C4O/s0p39B8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0118
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

[AMD Public Use]

Maybe commit body needs to be improved a bit like "Make sure to unlock the mutex for error case"

With above addressed, the patch is:
Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Wednesday, August 5, 2020 4:42 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: unlock mutex on error

Make sure unlock the mutex when error happen

Signed-off-by: Dennis Li <Dennis.Li@amd.com>
Change-Id: I6c36a193df5fe70516282d8136b4eadf32d20915

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index a0ea663ecdbc..5e5369abc6fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -632,13 +632,14 @@ int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
 	}
 
 	ret = amdgpu_ib_schedule(ring, 1, ib, job, &f);
+
+	up_read(&adev->reset_sem);
+
 	if (ret) {
 		DRM_ERROR("amdgpu: failed to schedule IB.\n");
 		goto err_ib_sched;
 	}
 
-	up_read(&adev->reset_sem);
-
 	ret = dma_fence_wait(f, false);
 
 err_ib_sched:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 4e017f379eb6..67a756f4337b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -545,7 +545,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 			}
 			ret = amdgpu_xgmi_update_topology(hive, tmp_adev);
 			if (ret)
-				goto exit;
+				goto exit_unlock;
 		}
 
 		/* get latest topology info for each device from psp */ @@ -558,7 +558,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 					tmp_adev->gmc.xgmi.node_id,
 					tmp_adev->gmc.xgmi.hive_id, ret);
 				/* To do : continue with some node failed or disable the whole hive */
-				goto exit;
+				goto exit_unlock;
 			}
 		}
 	}
@@ -566,7 +566,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 	if (!ret)
 		ret = amdgpu_xgmi_sysfs_add_dev_info(adev, hive);
 
-
+exit_unlock:
 	mutex_unlock(&hive->hive_lock);
 exit:
 	if (!ret)
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

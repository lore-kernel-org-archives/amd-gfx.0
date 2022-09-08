Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AE2ECAAD3
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 02:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5E1610E15E;
	Thu,  8 Sep 2022 02:01:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7699B10E15E
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 02:01:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yyusu9BM4JZrzapQoMF6HMpXWLPKVagCiPkOLqZqu39/F5alUhvvuiSwbiiDv/eR70AqxXn/MjI4EeGbJRheFAyV8ZpgYC9f6sO+u9zcNu4B6MBNLtzOlusdl5YPDXudh1RN8NliWyHlS5UgvdIIvhxtiCcYF5adZa0sRv9I7qA0l4ebcG9MVgYd3ETEDzABX8QJDiSF8FgWdthtsbpHkdqdtG6kptBis4DxlR0dUz1M+QtamBY+Ir29ThCA4K0JtGhEVZi8NyYCqkpYrFDBhBNEzH4Rosddt2Y3B1v104zoJRHhZdAt5g+LYwUz1fvn3fdQsbtto+3vJY3bBF/kYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QirmW1nv9GvKnaZda7e5JyBmSWhLcGl9BLoh86PJXHQ=;
 b=gnkr67c9PLeaUECeNfDmxMHQZLIM8SDfzxlTt3GAs7h+/0rBlrlmhLh7BQmWK1WoEdEe7WhZJ8Hsjz54FE+Van69mXjVM9seVk09RTyOMvfMj+cCsjbR7GEN/WMOiB1kzCRK30YLK6pgiKd4+bkJVPQ+vxkS2SNnkeOUApL5mqw2LILrZYxAw89VUpywgRaUZoKVrmQ8OTzW373BLAWTSYfQaHzLuBqbO35GwJK1gyack38tn9qDvjsb32zVR49TtHhntdY/KYlAJ2LVJhH4XNqqjg2FqO95WXQpF0eUYcPL6OyKUR5by5dTmjb0KbgIkgWBVsc05d+jMpQFdM1eZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QirmW1nv9GvKnaZda7e5JyBmSWhLcGl9BLoh86PJXHQ=;
 b=jE9PcS5XCiWhwwZc62RuD9KcCAYbdur1vK5ROekaKwhGbCz2skRTTNoof6hptoLLyWvqjgZyHYhNsbP9vpuK8FUwfawldP8EnHn9+Ezf0XJENP23OuNuVnvuGMTbbiRVfHeN4lv3yCq24hy4z6CQxxcSvF/a9yrOkkCZyg2cMJI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Thu, 8 Sep
 2022 02:01:14 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28%5]) with mapi id 15.20.5588.018; Thu, 8 Sep 2022
 02:01:14 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Use per device reset_domain for XGMI on sriov
 configuration
Thread-Topic: [PATCH] drm/amdgpu: Use per device reset_domain for XGMI on
 sriov configuration
Thread-Index: AQHYws/yLcIBF8rNXkqKDL9scgwPEq3Up5cAgAAgaR4=
Date: Thu, 8 Sep 2022 02:01:14 +0000
Message-ID: <BN9PR12MB5257D5EDF30177E66F53984AFC409@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220907153803.24370-1-shaoyun.liu@amd.com>
 <CH0PR12MB5372A46F350E46A9953114F1F4409@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5372A46F350E46A9953114F1F4409@CH0PR12MB5372.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-08T00:04:37.0000000Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ab623b1-49be-4de4-5e63-08da913e02a8
x-ms-traffictypediagnostic: SJ0PR12MB6880:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HuQb78WnI0KN1eh2iBRB4Lnc84V8pXeE25txwgnBSs8DOOHZKScV8+57uI7mxjIAdIV77BSthrTs+M1+yvlxjz0kJQgQw3hQWUpo88DaNe0aMQw3duHKZ1VE3P7YaIV6DtBQ2XRExY6eYeXvyrhPgzH6CG1vUKFvxUcV0zCD0QPA7yZGOzan3QnOS7GgIUwH2jrqDyD6JKLKfAr0vqD1+B9n79XGC7mlf0qhgQqUbWrjiPRmijrLF4wlfHLIX3vxa47bsmtR2+lmlTEmq/ymnbLQNvfyoCxKBy+WHNKzjC5kJ6JS/7w+urUO4hUnPPTe/vhdXbH08JBabuCcbqsAsFR6t2gY3xZ2shQmxbuZSK3j/rYvl+mjWoB4IUwCsIdoUWYONmJW7cxUGwiyy4JyaURGF3jQ/s1xpNZvbPWn/5UkcyswYuPIKEXhNw67L5w71YG1NRJbWM8OPw/FKZpCnjCBSqAd68h9UXK/24e6AYh3PE79aL5z0tS1LOaPPaGYzqebTHDeQcSqkmxEbzzKBWp6pTdL4yp3C/+AfGgbfZEwDyxanSuicGvDW6DuEg923YMC9EF3871eOZQ6gcdiCz8bt+2ejcpMarNdfmKF4+F2TRk4rNbMnvzWz/7SQyRcMtvdTqt+I/WqhpWtbb/FKJt+ZH//y73Xv9TQFKDWUJTicU7jNgnW+NGdlf5lBk4EtcMgcfxDjx94q/z4GdeyaxzmHRjWDBWZC1IKjasmf9OqtDNSgi2LHDSMIje/90rkmmdLIp16HtnbdanSDcKcYaPS7C4iqVtZHPWopGD9gao=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(66556008)(110136005)(316002)(478600001)(966005)(2906002)(66946007)(66446008)(66476007)(45080400002)(86362001)(122000001)(33656002)(91956017)(76116006)(166002)(38100700002)(38070700005)(8676002)(9686003)(71200400001)(6506007)(26005)(53546011)(41300700001)(7696005)(186003)(64756008)(55016003)(83380400001)(5660300002)(52536014)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kwj2CZ1Rg8e+XQzPGj9aRLmIvJeH7QikafbSfM201iMIcdGCWijAN490D0CY?=
 =?us-ascii?Q?Q2G2Za3zdP1E+9AfSXbGwADzE2DiVuUPZrgPyqQ/JE4127+Rx1BiFBcgY2Zu?=
 =?us-ascii?Q?bqAtLyIps5qBHy7bLRq8qRDv2/j2jma5jijFK/DYGH2gxQLJi9gxKbpdCd78?=
 =?us-ascii?Q?7NuNKJkevhfum5LPcti2SIhvcDkNLcC0g3B5aHBnHnK7iU7nFBd7s8J3+mg+?=
 =?us-ascii?Q?mSyrPrBCvhgLLYO45QSQ3fIecaJ4ugPttIHMGOPiSZSl9+s8jmQxNUPqX/GP?=
 =?us-ascii?Q?lMLnl2dyG6U4hBxRC2suBlETKrJuH1Bi9VZRwyz9PhaDhmjtUKSY3nuogDMg?=
 =?us-ascii?Q?L4VuSoQ1cyKGxebJXU/xWLZqlQz5GgV/BTywQx0aJPWZduTy2ug5ZMTt2cfY?=
 =?us-ascii?Q?dYSgWQXSkB/nBalARvGFh25J1mBI+7Sf3BFQT74xBHyEn84iQipOUMQ/Be5C?=
 =?us-ascii?Q?1EItJ6l1c1J3JS9d3LmlJCcRv7QukFZvgEv/pTZVpENM6/Xt1H6V0NNLmxTn?=
 =?us-ascii?Q?CK8/+hOmsO14zXxM5wH2cEiUMhUQ7YEoAwWQk3OKVvSA40z901c9Ik2PWs0v?=
 =?us-ascii?Q?Z+m3QJzL6MURp+9J9dRKWilJchEqBMymq8b0rmjJbbna+WVTRUmuxjxxUXvs?=
 =?us-ascii?Q?tq5ZLD0GmSaJ/3KlG8fQX4wCuLvsVCcHKa4zn6jpVOAzKdNyb4IgpjUZCNaE?=
 =?us-ascii?Q?EgFhKFmNyoWUn8uPW1aBEYNHbOvpmZM3RpbhkWfjIN3KQL1K2OPh6Wqjb925?=
 =?us-ascii?Q?toyJrdOzR4/TZgYXysJCbCUNENFWs2TN0i+SuC9tIDDD77jQwZcShT4bscnq?=
 =?us-ascii?Q?H7MMIk5LBkBxo+87mj6OQ7xJhQL80fCFKfAsTFdqaA3US7LYMJ2kN2LUvL+A?=
 =?us-ascii?Q?3yAavZzEvA189bH7KM0L9fi0oDn2HJQqiOkO3KwNWwvZhn3sLrGWgO9vQHbH?=
 =?us-ascii?Q?K/Ngpdh6kiPadjxt8h6TeiOTrcOXmwtRa5PdJEIS8RE8RwNJw6wyFMEHhPy+?=
 =?us-ascii?Q?pPQ5cWDA9m/+Jz44MJvPMZwll47TWWBwK6mRqeGZIbx8iu4KFPxKxvstP3OW?=
 =?us-ascii?Q?4Y7FQxJTfdsvzGe9cDJvrQFRtCEHA3ometE5IKXg2WNYGlOHpjxXmyJ2ZiEi?=
 =?us-ascii?Q?xk8JxyODXaky2oQzX5vqtdle6WQfxmkCkAxaE7mCTQreDpx2oq7GleZQYl7m?=
 =?us-ascii?Q?HkYHwyYhOVpEHYiorDFGEiUH8lZ2BqEzvmd4vooUNfhPw+lrejEIWkUi3lfz?=
 =?us-ascii?Q?OpzuPRhMJBP8i6ZphKdXdwr/bACLeJ4gt04OlrZuzwq+jyRaLDq/xB6Mlc9Y?=
 =?us-ascii?Q?VRaoGZJkKJuq3GzcgypOAwRSPC1CYPf0rgYOeXFWJjJ8qq/qbKrWtAck9/ny?=
 =?us-ascii?Q?yk+L7WQYcmbirW+kY48jM0u8dOpi32PYAPkflTlhN6xD5wE0dO1bGMV+DkYL?=
 =?us-ascii?Q?pEJ8ZOkAmZMmD+q1ORHYjudpq+PnT2OVRTi1oFjn9ZPIni8ffgbCla9gX0iF?=
 =?us-ascii?Q?nAxMgycz6l7S5hrCKqWvTUWRoSzJjCBrApvDBGogc2uN+dSySkNkcQyl6+Ie?=
 =?us-ascii?Q?Yf3efiUmCQcFHMEuYEgAzBidKdNhuefvsazsRYjXd2eFNCIxy5Xo66ZMJ739?=
 =?us-ascii?Q?ng=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5257D5EDF30177E66F53984AFC409BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab623b1-49be-4de4-5e63-08da913e02a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 02:01:14.4778 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qWBRBKvkgUqvk8Bohq2wbpQbvZBdt5GgUFOeiKXMBIFwOFY9ohGe6cCW2pyo2CGjYTglmPCtW/bTOPW1qxhbPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880
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

--_000_BN9PR12MB5257D5EDF30177E66F53984AFC409BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Liu, Sha=
oyun <Shaoyun.Liu@amd.com>
Date: Thursday, September 8, 2022 at 08:05
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Use per device reset_domain for XGMI on sr=
iov configuration
[AMD Official Use Only - General]

[AMD Official Use Only - General]

ping

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Sent: Wednesday, September 7, 2022 11:38 AM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Use per device reset_domain for XGMI on sriov =
configuration

For SRIOV configuration, host driver control the reset method(either FLR or=
 heavier chain reset). The host will notify the guest individually with FLR=
 message if individual GPU within the hive need to be reset. So for guest s=
ide, no need to use hive->reset_domain to replace the original per device r=
eset_domain

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 36 +++++++++++++---------
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 62b26f0e37b0..a5533e0d9d6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2453,17 +2453,19 @@ static int amdgpu_device_ip_init(struct amdgpu_devi=
ce *adev)
                if (amdgpu_xgmi_add_device(adev) =3D=3D 0) {
                        struct amdgpu_hive_info *hive =3D amdgpu_get_xgmi_h=
ive(adev);

-                       if (!hive->reset_domain ||
-                           !amdgpu_reset_get_reset_domain(hive->reset_doma=
in)) {
-                               r =3D -ENOENT;
+                       if(!amdgpu_sriov_vf(adev)) {
+                               if (!hive->reset_domain ||
+                                   !amdgpu_reset_get_reset_domain(hive->re=
set_domain)) {
+                                       r =3D -ENOENT;
+                                       amdgpu_put_xgmi_hive(hive);
+                                       goto init_failed;
+                               }
+
+                               /* Drop the early temporary reset domain we=
 created for device */
+                               amdgpu_reset_put_reset_domain(adev->reset_d=
omain);
+                               adev->reset_domain =3D hive->reset_domain;
                                amdgpu_put_xgmi_hive(hive);
-                               goto init_failed;
                        }
-
-                       /* Drop the early temporary reset domain we created=
 for device */
-                       amdgpu_reset_put_reset_domain(adev->reset_domain);
-                       adev->reset_domain =3D hive->reset_domain;
-                       amdgpu_put_xgmi_hive(hive);
                }
        }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index d3b483aa81f8..a78b589e4f4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -391,24 +391,32 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct =
amdgpu_device *adev)
                goto pro_end;
        }

+       /**
+        * Only init hive->reset_domain for none SRIOV configuration. For S=
RIOV,
+        * Host driver decide how to reset the GPU either through FLR or ch=
ain reset.
+        * Guest side will get individual notifications from the host for t=
he FLR
+        * if necessary.
+        */
+       if (!amdgpu_sriov_vf(adev)) {
        /**
         * Avoid recreating reset domain when hive is reconstructed for the=
 case
-        * of reset the devices in the XGMI hive during probe for SRIOV
+        * of reset the devices in the XGMI hive during probe for passthrou=
gh
+GPU
         * See https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Fwww.spinics.net%2Flists%2Famd-gfx%2Fmsg58836.html&amp;data=3D05%7C0=
1%7Chawking.zhang%40amd.com%7C1cc58853b47048a4e25208da912dc783%7C3dd8961fe4=
884e608e11a82d994e183d%7C0%7C0%7C637981923054102228%7CUnknown%7CTWFpbGZsb3d=
8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%=
7C%7C%7C&amp;sdata=3DDmZeEevkv%2FlVa07m0HUCkC6ozH0BgJ4uPGnYe41NAOs%3D&amp;r=
eserved=3D0
         */
-       if (adev->reset_domain->type !=3D XGMI_HIVE) {
-               hive->reset_domain =3D amdgpu_reset_create_reset_domain(XGM=
I_HIVE, "amdgpu-reset-hive");
-                       if (!hive->reset_domain) {
-                               dev_err(adev->dev, "XGMI: failed initializi=
ng reset domain for xgmi hive\n");
-                               ret =3D -ENOMEM;
-                               kobject_put(&hive->kobj);
-                               kfree(hive);
-                               hive =3D NULL;
-                               goto pro_end;
-                       }
-       } else {
-               amdgpu_reset_get_reset_domain(adev->reset_domain);
-               hive->reset_domain =3D adev->reset_domain;
+               if (adev->reset_domain->type !=3D XGMI_HIVE) {
+                       hive->reset_domain =3D amdgpu_reset_create_reset_do=
main(XGMI_HIVE, "amdgpu-reset-hive");
+                               if (!hive->reset_domain) {
+                                       dev_err(adev->dev, "XGMI: failed in=
itializing reset domain for xgmi hive\n");
+                                       ret =3D -ENOMEM;
+                                       kobject_put(&hive->kobj);
+                                       kfree(hive);
+                                       hive =3D NULL;
+                                       goto pro_end;
+                               }
+               } else {
+                       amdgpu_reset_get_reset_domain(adev->reset_domain);
+                       hive->reset_domain =3D adev->reset_domain;
+               }
        }

        hive->hive_id =3D adev->gmc.xgmi.hive_id;
--
2.17.1

--_000_BN9PR12MB5257D5EDF30177E66F53984AFC409BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Reviewed-by: Hawkin=
g Zhang &lt;Hawking.Zhang@amd.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Regards,<br>
Hawking<o:p></o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Liu, Shaoyun &lt;Shaoyun.Li=
u@amd.com&gt;<br>
<b>Date: </b>Thursday, September 8, 2022 at 08:05<br>
<b>To: </b>amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject: </b>RE: [PATCH] drm/amdgpu: Use per device reset_domain for XGM=
I on sriov configuration<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">[AMD Official Use Only - General]<br>
<br>
[AMD Official Use Only - General]<br>
<br>
ping<br>
<br>
-----Original Message-----<br>
From: Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;<br>
Sent: Wednesday, September 7, 2022 11:38 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu: Use per device reset_domain for XGMI on sriov =
configuration<br>
<br>
For SRIOV configuration, host driver control the reset method(either FLR or=
 heavier chain reset). The host will notify the guest individually with FLR=
 message if individual GPU within the hive need to be reset. So for guest s=
ide, no need to use hive-&gt;reset_domain
 to replace the original per device reset_domain<br>
<br>
Signed-off-by: shaoyunl &lt;shaoyun.liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 ++++++------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c&nbsp;&nbsp; | 36 +++++++++++=
++---------<br>
&nbsp;2 files changed, 33 insertions(+), 23 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 62b26f0e37b0..a5533e0d9d6c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2453,17 +2453,19 @@ static int amdgpu_device_ip_init(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (amdgpu_xgmi_add_device(adev) =3D=3D 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdg=
pu_hive_info *hive =3D amdgpu_get_xgmi_hive(adev);<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hive-&gt;re=
set_domain ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; !amdgpu_reset_get_reset_domain(hive-&gt;reset_domain)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D -ENOENT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(!amdgpu_sriov=
_vf(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hive-&gt;reset_domain ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !amdgpu_reset_get_r=
eset_domain(hive-&gt;reset_domain)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; r =3D -ENOENT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; amdgpu_put_xgmi_hive(hive);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; goto init_failed;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Drop the early temporary reset domain we=
 created for device */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_put_reset_domain(adev-&gt;rese=
t_domain);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;reset_domain =3D hive-&gt;reset_do=
main;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_put_xgmi_hive(hive);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto init_failed;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Drop the earl=
y temporary reset domain we created for device */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_put=
_reset_domain(adev-&gt;reset_domain);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;reset_d=
omain =3D hive-&gt;reset_domain;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_put_xgmi_=
hive(hive);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c<br>
index d3b483aa81f8..a78b589e4f4f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
@@ -391,24 +391,32 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct =
amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; goto pro_end;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Only init hive-&gt;reset_doma=
in for none SRIOV configuration. For SRIOV,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Host driver decide how to res=
et the GPU either through FLR or chain reset.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Guest side will get individua=
l notifications from the host for the FLR<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * if necessary.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Avoid recreating reset d=
omain when hive is reconstructed for the case<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * of reset the devices in the X=
GMI hive during probe for SRIOV<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * of reset the devices in the X=
GMI hive during probe for passthrough<br>
+GPU<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * See <a href=3D"https://n=
am11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.spinics.net%=
2Flists%2Famd-gfx%2Fmsg58836.html&amp;amp;data=3D05%7C01%7Chawking.zhang%40=
amd.com%7C1cc58853b47048a4e25208da912dc783%7C3dd8961fe4884e608e11a82d994e18=
3d%7C0%7C0%7C637981923054102228%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDA=
iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sda=
ta=3DDmZeEevkv%2FlVa07m0HUCkC6ozH0BgJ4uPGnYe41NAOs%3D&amp;amp;reserved=3D0"=
>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.spi=
nics.net%2Flists%2Famd-gfx%2Fmsg58836.html&amp;amp;data=3D05%7C01%7Chawking=
.zhang%40amd.com%7C1cc58853b47048a4e25208da912dc783%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637981923054102228%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&am=
p;amp;sdata=3DDmZeEevkv%2FlVa07m0HUCkC6ozH0BgJ4uPGnYe41NAOs%3D&amp;amp;rese=
rved=3D0</a><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;reset_domain-&gt;type !=
=3D XGMI_HIVE) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hive-&gt;reset_domain =3D amdgpu_reset_create_reset_domain(XGMI_=
HIVE, &quot;amdgpu-reset-hive&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hive-&gt;re=
set_domain) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;XGMI: failed in=
itializing reset domain for xgmi hive\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D -ENOMEM;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_put(&amp;hive-&gt;kobj);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hive);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hive =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto pro_end;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_reset_get_reset_domain(adev-&gt;reset_domain);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hive-&gt;reset_domain =3D adev-&gt;reset_domain;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;reset_domain-&gt;type !=3D XGMI_HIVE) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hive-&gt;reset_d=
omain =3D amdgpu_reset_create_reset_domain(XGMI_HIVE, &quot;amdgpu-reset-hi=
ve&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hive-&gt;reset_domain) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dev_err(adev-&gt;dev, &quot;XGMI: failed initializing reset domain for=
 xgmi hive\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ret =3D -ENOMEM;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; kobject_put(&amp;hive-&gt;kobj);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; kfree(hive);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; hive =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; goto pro_end;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_get=
_reset_domain(adev-&gt;reset_domain);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hive-&gt;reset_d=
omain =3D adev-&gt;reset_domain;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hive-&gt;hive_id =3D adev-&gt;gm=
c.xgmi.hive_id;<br>
--<br>
2.17.1<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB5257D5EDF30177E66F53984AFC409BN9PR12MB5257namp_--

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEDEC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 17:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6868A10E160;
	Mon, 21 Feb 2022 17:15:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1D5510E160
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 17:15:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mtnk8vngv7upqEQ+b+SxonzhesBpT50cNIoV+CBVjlFXb09Abix9KgfVCvV5a+LiDxxW7Xx8b241q5w55rr3G+ek+8Uw0jZF0m4LZ77X3YPx7br6h4hz6Ae1fsBl8wt+RGdZmEdBWfRD+FYq00RN5OsMsaWmH9QwJd0QxiFP6K+QNEVdU9R3R7DQJ4PGEY8H52MF42nHSEEzxHsoKiE9Iq8abqffIeRIkju5gLUT4JPe/lKZNfRgUzkdx3TUas1rLn2E1gVZsLtw3oE9yKWbdR7dXPCSRIZbZ0dYOckseyKiwzaj94OxNU80m5hiYvHy4mbCeJhrxzhEN95f+zUzwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJJK9hbH2Jw2pbelYC/mXcSVFYKQ7x8eCn0wKexEQDs=;
 b=h83mt6AcHbv3MVNubdoaRxRRQFmTWyUNyoN+xeSKBHrxqctZ6MMrTpDyyoBZLhTrpd8/e6VT0VF5TLIMQxJ/O6vPiKuQuu9FnjpUQt4xAtv7sHYhYApzX1xa9a4ysAWqFYzGIsfmQdTUo4bSMyhq4+8n6MlJiN5xp6fXnJvShLgjk9yZrsfQ1SzFpW3ZH5/hXcvLDBFhy3AbXMg9E3oxIgJHEvHrkpekMiwAHTO5ywiipV/6pbuneOwxBvi3+DaYqA6PfZ60JziwYq/TOiqb0jDa3ksKT7/BwkMAlwZl1k8C0XLC7/b/ID87D1EW65dVoxATvg36Ska2ZSibH2Avsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJJK9hbH2Jw2pbelYC/mXcSVFYKQ7x8eCn0wKexEQDs=;
 b=eZnVn93S6gt+xZgchUJlQxmsnwZAFDYMwrzDpDIkDvFIpD80h20r21KzDym6mRpBwtFa5Rtzch4NBbZJbuHIuYCCcKEXXixHoNlZbaKX5OIrdSxNKiviNEDTIcaetL4ZctvYbCTjdwOPK1suEqwabl4uihsgeNAxdCFY5G21cW8=
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by MN2PR12MB3277.namprd12.prod.outlook.com (2603:10b6:208:103::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Mon, 21 Feb
 2022 17:15:18 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::922:40dc:9c59:b18d]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::922:40dc:9c59:b18d%2]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 17:15:18 +0000
From: "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Somalapuram, Amaranath"
 <Amaranath.Somalapuram@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v9 1/2] drm/amdgpu: add debugfs for reset registers list
Thread-Topic: [PATCH v9 1/2] drm/amdgpu: add debugfs for reset registers list
Thread-Index: AQHYJyfHx5GV2l/mUUKoTOH9APF0iKyeArCAgABnIgD//6Z6gIAAipoA
Date: Mon, 21 Feb 2022 17:15:18 +0000
Message-ID: <DM6PR12MB38976DE0677BDF4DE12AAAA4F83A9@DM6PR12MB3897.namprd12.prod.outlook.com>
References: <20220221133411.12544-1-Amaranath.Somalapuram@amd.com>
 <3a66af2c-edd2-cc0b-1caa-8fa989b94a02@amd.com>
 <DM6PR12MB389730FB7E38A62EA781C141F83A9@DM6PR12MB3897.namprd12.prod.outlook.com>
 <c4eff3b2-fa00-1bd4-09af-3f8258228c84@amd.com>
In-Reply-To: <c4eff3b2-fa00-1bd4-09af-3f8258228c84@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-21T17:15:12Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f8336a00-4828-4bef-bb3a-1066cffc8955;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
x-ms-exchange-imapappendstamp: DM6PR12MB3897.namprd12.prod.outlook.com
 (15.20.4995.027)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa5d1b05-3d74-4726-a155-08d9f55dbc1c
x-ms-traffictypediagnostic: MN2PR12MB3277:EE_
x-microsoft-antispam-prvs: <MN2PR12MB32770F99CF9E5ADEC4D3AA3AF83A9@MN2PR12MB3277.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lGngvik+rjp2F28J8HpOHnYRYhcdFSxmqia/EnlL8IUOofCO4K6sDKnpG4XGtY5IKIbLC7PDy/sGLmNyOSMhQ0NWGMnIgsEmyrjrbxcKGCwqW0V9SYPqyWBbw/pcfEo9aKiI0557EKaNPtGXhHWUN6f/FGN/6Gnr/HtJyLS7zC76GevdDkPsisG5TIQhR1j18dORod+BNAQDjhnegtrajv3RWiqbuZuHUHPCt0UnohUe3RqHjmjYmRj9flfIzUZaOc2E7+V5feC0u2IcbzAy4T2Y7/+xeIhNT+svn7ZlDF0kjQ4aPzTQF+BjBXXSA2J5XMJXjQ3fouULFJAOLLpHh4YRLBryM6lVUKve+GitVvLJNZzZKeWocWy7Fwlj7ohYS4vB9nsMhk0oNxgCrF2NlGM8cnW2nRTeZGTcr4DcIoeVo0LArQJmP16wsv6R2lviIyL1ft5kk0d6qnB+D5E/SfN3vfohnCq5tZsCRjOT8lEDZvo5GEV0nY9DYc0lO39j7l3wtt06pvemPixUgNkaoV7gOFjutjnJHfHjOikjcc4WsfDZVK7ewrI+VkIcUZCJtOOKhp2g3seA/2nF7zAwhflLNtCM4ez2pbhMd8dRBU5TWOU67VLp3RgtWSSg8+mt6i/ASo5PCkxkZh5DWvYU5jdr3gvJ5LpVUqvIx8V9UdTPFdOzf2mjJWNjeFsn4r9W3Uja1ypYQH2wrZ5pV2wodvZZSuIwpbaA7JStiiJJreMKi1qzG1DsM5y1wP3lW7Sg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(38070700005)(66574015)(38100700002)(83380400001)(52536014)(5660300002)(55016003)(2906002)(8936002)(33656002)(71200400001)(6506007)(26005)(110136005)(53546011)(186003)(76116006)(9686003)(66556008)(66946007)(7696005)(54906003)(122000001)(66446008)(8676002)(508600001)(316002)(64756008)(66476007)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+AdZaQi+BAP0dFUPXk21lUSnTZMAyWLzjbJ4zE+HltCC/R0kbiXZpabye9?=
 =?iso-8859-1?Q?Z65MyTMzsKWDcNXpY581gD9lcVdh5fuvziNVdZHqAEtknj78OIePkk7+CZ?=
 =?iso-8859-1?Q?1VaCWcxECQ2AzpYqZZrfYF6HNtQGMKb+5690ZHW42g2PwUx81HyZ3KEb2P?=
 =?iso-8859-1?Q?R5gCdynQgt5VkO02NWB/wjOFRQ9937+Csp5kk29p2kU/Rsgr0+EJYpaGuE?=
 =?iso-8859-1?Q?/Ic3s+Jdea4ZrX0z+ZMcBSJiUlp3eFkU1sg6D1RarCvepWOWr1fAY5z3Tg?=
 =?iso-8859-1?Q?hqxJkrkdQPOFfTUgNyN3xiX/11MI0KvNUFmplePITrmWZTYVW2WvdTncJo?=
 =?iso-8859-1?Q?KR0BFaPJ/4N7JXWCbVY8nOqJhrNMRPSDeG33E8UENwIX8XPvJIDginbv6Q?=
 =?iso-8859-1?Q?JBqnn4Ez98J6GxfnDto3P//j0jEmUXcr2JBTfkWiWI2/dHmJy5sy+bdafz?=
 =?iso-8859-1?Q?L5zx1hK1smJM4Ma+NdNCq6QqNmELOeBqAhHTgpPnpcYRUBm6ioW1hbR4ZG?=
 =?iso-8859-1?Q?oo2EbB9MhHk7rS6IMuqglqNvV7vLywrcmHgYAm6Ev74AruNgPf7Ol9t9lI?=
 =?iso-8859-1?Q?2S8HLr2m4MnY9g6t2CheukvFNiWb4qeK7148Tjfp5Z3/jYRjT7D+VhfUN8?=
 =?iso-8859-1?Q?enPNN2CUqZ1qxSdB5iAw/o76DRsVRuQsBya0eR0p5XsFfXYu9felXQmvtR?=
 =?iso-8859-1?Q?W+Yikyue56AiizDOSxwwqhc96tvqJposOny0EDRkT//ijL4Q6xpEKc58Vv?=
 =?iso-8859-1?Q?oeNZ6tcMhIWKWaHjjdfsJQatvnxhbuw61w2Q1XZmHAGZAyGX5QMiu3gJ+s?=
 =?iso-8859-1?Q?WLUbtiz2+y63gopK/84OjufU9gJXeyc8N/x4Ei7PeRNdr+Se8shMSOdij7?=
 =?iso-8859-1?Q?E2W38IpD21VrW4KPVz3I7dkXQOT9NXizD0Wk11+VmFbS5b/y9LpaUfdtr7?=
 =?iso-8859-1?Q?bGyl2kWCZqgEozxzKaYy2WRgAZHxGvJqyMmCMAhxS8fu/fnuBvX+BsCZPZ?=
 =?iso-8859-1?Q?PT7Al15Y5vvkntba1XUCjB/Vbs9Aaaz8ERl/yQZRGFANkVz0ZndWPOitBt?=
 =?iso-8859-1?Q?H8/sOW1WJJEtKrHFMAs/gR/3K5CudQY/oiA+Zcc844eOuSgjiDSqyiXThD?=
 =?iso-8859-1?Q?sUdX3ahFVKmd408ZUA63L3sYDjUoZomt+S+eK/FTSetZSUWrro2NmxuyBQ?=
 =?iso-8859-1?Q?LAWhT8QrikprTp/7nBM8h5TUPXROz1Mpk2/TaQG6kymrwclc87uZGykZqV?=
 =?iso-8859-1?Q?zXay41Kj5BTkMxisNe2P3OlUE/PVj+kIHCslqYtoFjlr+eqB22GdtQCrQ/?=
 =?iso-8859-1?Q?iYad1KzjOmGV4u8MiTc06fIa5ODJpXhnaLm8iWQTdnZ4SWrf84J0pHwbBF?=
 =?iso-8859-1?Q?XwHaHbEcFeXLxPKH27u0zCSw6+mLt0rNBGuqZnMzAsWUut80rLNyH/wzN+?=
 =?iso-8859-1?Q?CqhOzA5kyza+KpMQ30vZKNNxqGWerulK+AijZS/y1oXJCG4OiLBvOZed+K?=
 =?iso-8859-1?Q?v7NdYQnZQU9yysm9tK44/OduOQyr77Uslx84MWSeu997KTW7Sz0PXViYGJ?=
 =?iso-8859-1?Q?511Nfr8aBwKJVjfAR6PnbE82zs7baXcsHTS3zLP2QNgJ/hTExHaunf+vmo?=
 =?iso-8859-1?Q?98wtFpY/vzXAoWSlsIXPTIkOp8xI82A+r1P/HDcCRbJnilNYZMOFnlWqkB?=
 =?iso-8859-1?Q?nVFCGv677zpMOxEI+po=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB38976DE0677BDF4DE12AAAA4F83A9DM6PR12MB3897namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5d1b05-3d74-4726-a155-08d9f55dbc1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 17:15:18.4830 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6oMkhRi8rUm+btTiAwAwhaIrBliJBWab68G9zoxoD2793hZvyMFDFyK5Gpy4APo8hwjf2dtZ2JoUhDPeT75Wbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3277
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB38976DE0677BDF4DE12AAAA4F83A9DM6PR12MB3897namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]



On 2/21/2022 7:58 PM, Christian K=F6nig wrote:
Am 21.02.22 um 15:19 schrieb Somalapuram, Amaranath:

[AMD Official Use Only]


On 2/21/2022 7:09 PM, Christian K=F6nig wrote:


Am 21.02.22 um 14:34 schrieb Somalapuram Amaranath:

List of register populated for dump collection during the GPU reset.

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com><mailto=
:Amaranath.Somalapuram@amd.com>
---
   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 +
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 96 +++++++++++++++++++++
   2 files changed, 100 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b85b67a88a3d..6e35f2c4c869 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1097,6 +1097,10 @@ struct amdgpu_device {
         struct amdgpu_reset_control     *reset_cntl;
       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
+
+    /* reset dump register */
+    uint32_t            *reset_dump_reg_list;
+    int                             num_regs;
   };
     static inline struct amdgpu_device *drm_to_adev(struct drm_device
*ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 164d6a9e9fbb..69c0a28deeac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1609,6 +1609,100 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
               amdgpu_debugfs_sclk_set, "%llu\n");
   +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
+                char __user *buf, size_t size, loff_t *pos)
+{
+    struct amdgpu_device *adev =3D (struct amdgpu_device
*)file_inode(f)->i_private;
+    char reg_offset[11];
+    int i, ret, len =3D 0;
+
+    if (*pos)
+        return 0;
+
+    ret =3D down_read_killable(&adev->reset_sem);
+
+    if (ret)
+        return ret;
We usually don't have an empty line between function call and checking
the return code.


+
+    for (i =3D 0; i < adev->num_regs; i++) {
+        down_read(&adev->reset_sem);
That here will just crash because we have already locked the semaphore
before the loop.
unfortunately it did not crash. Sorry I misunderstood your earlier comments=
.

+        sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
+        up_read(&adev->reset_sem);
+        ret =3D copy_to_user(buf + len, reg_offset, strlen(reg_offset));
+
+        if (ret)
+            goto error;
+
+        len +=3D strlen(reg_offset);
And here the down_read_killable() is missing.


+    }
+
+    up_read(&adev->reset_sem);
+    ret =3D copy_to_user(buf + len, "\n", 1);
+
+    if (ret)
+        return -EFAULT;
+
+    len++;
+    *pos +=3D len;
+
+    return len;
+error:
+    up_read(&adev->reset_sem);
+    return -EFAULT;
+}
+
+static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
+            const char __user *buf, size_t size, loff_t *pos)
+{
+    struct amdgpu_device *adev =3D (struct amdgpu_device
*)file_inode(f)->i_private;
+    char *reg_offset, *reg, reg_temp[11];
+    uint32_t *tmp;
+    int ret, i =3D 0, len =3D 0;
+
+    do {
+        reg_offset =3D reg_temp;
I think you can just drop the reg_offset variable;
strsep takes only pointer as input, this is workaround.

Ah, now I see what you are doing here.

Please don't do it like that. Better use memchr() instead.

memchr will not work. I couldn't find any other string API I can use.

other references similar to code:
static void amdgpu_device_enable_virtual_display(struct amdgpu_device *adev=
)
{
    adev->enable_virtual_display =3D false;

    if (amdgpu_virtual_display) {
        const char *pci_address_name =3D pci_name(adev->pdev);
        char *pciaddstr, *pciaddstr_tmp, *pciaddname_tmp, *pciaddname;

        pciaddstr =3D kstrdup(amdgpu_virtual_display, GFP_KERNEL);
        pciaddstr_tmp =3D pciaddstr;
        while ((pciaddname_tmp =3D strsep(&pciaddstr_tmp, ";"))) {
            pciaddname =3D strsep(&pciaddname_tmp, ",");


+        memset(reg_offset, 0, 11);
+        ret =3D copy_from_user(reg_offset, buf + len, min(11,
((int)size-len)));
+
+        if (ret)
+            goto error_free;
+
+        reg =3D strsep(&reg_offset, " ");
+        tmp =3D krealloc_array(tmp, 1, sizeof(uint32_t), GFP_KERNEL);
That must be krealloc_array(tmp, i, ... not krealloc_array(tmp, 1, ... !
I thought it will append (if not it should have crashed or some kernel dump=
)

No, krealloc_array works similar to realloc() in userspace.

You need to give it the full size of the necessary space.

Regards,
Christian.


Regards,
Christian.


+        ret =3D kstrtouint(reg, 16, &tmp[i]);
+
+        if (ret)
+            goto error_free;
+
+        len +=3D strlen(reg) + 1;
+        i++;
+
+    } while (len < size);
+
+    ret =3D down_write_killable(&adev->reset_sem);
+
+    if (ret)
+        goto error_free;
+
+    swap(adev->reset_dump_reg_list, tmp);
+    adev->num_regs =3D i;
+    up_write(&adev->reset_sem);
+    ret =3D size;
+
+error_free:
+    kfree(tmp);
+    return ret;
+}
+
+
+
+static const struct file_operations amdgpu_reset_dump_register_list =3D {
+    .owner =3D THIS_MODULE,
+    .read =3D amdgpu_reset_dump_register_list_read,
+    .write =3D amdgpu_reset_dump_register_list_write,
+    .llseek =3D default_llseek
+};
+
   int amdgpu_debugfs_init(struct amdgpu_device *adev)
   {
       struct dentry *root =3D adev_to_drm(adev)->primary->debugfs_root;
@@ -1672,6 +1766,8 @@ int amdgpu_debugfs_init(struct amdgpu_device
*adev)
                   &amdgpu_debugfs_test_ib_fops);
       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
                   &amdgpu_debugfs_vm_info_fops);
+    debugfs_create_file("amdgpu_reset_dump_register_list", 0644,
root, adev,
+                &amdgpu_reset_dump_register_list);
         adev->debugfs_vbios_blob.data =3D adev->bios;
       adev->debugfs_vbios_blob.size =3D adev->bios_size;
>


--_000_DM6PR12MB38976DE0677BDF4DE12AAAA4F83A9DM6PR12MB3897namp_
Content-Type: text/html; charset="iso-8859-1"
Content-ID: <028E04085E59AC489858B98C2FA5E367@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-compose;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<p class=3D"msipheadera4477989" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0000FF">[AMD Official Use O=
nly]</span></p>
<br>
<div class=3D"WordSection1">
<p><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">On 2/21/2022 7:58 PM, Christian K=F6nig wrote:<o:p><=
/o:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal">Am 21.02.22 um 15:19 schrieb Somalapuram, Amaranath:=
 <br>
<br>
<o:p></o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal">[AMD Official Use Only] <br>
<br>
<br>
On 2/21/2022 7:09 PM, Christian K=F6nig wrote: <br>
<br>
<o:p></o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal"><br>
Am 21.02.22 um 14:34 schrieb Somalapuram Amaranath: <br>
<br>
<o:p></o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal">List of register populated for dump collection durin=
g the GPU reset.
<br>
<br>
Signed-off-by: Somalapuram Amaranath <a href=3D"mailto:Amaranath.Somalapura=
m@amd.com">
&lt;Amaranath.Somalapuram@amd.com&gt;</a> <br>
--- <br>
&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 + <br>
&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 96 +++++++++++++=
++++++++ <br>
&nbsp;&nbsp; 2 files changed, 100 insertions(+) <br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
b/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
index b85b67a88a3d..6e35f2c4c869 100644 <br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
@@ -1097,6 +1097,10 @@ struct amdgpu_device { <br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_control&nbs=
p;&nbsp;&nbsp;&nbsp; *reset_cntl; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ip_versions[HW_ID_MAX][HWIP_M=
AX_INSTANCE]; <br>
+ <br>
+&nbsp;&nbsp;&nbsp; /* reset dump register */ <br>
+&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *reset_dump_reg_list; <br>
+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_regs; <br>
&nbsp;&nbsp; }; <br>
&nbsp;&nbsp; &nbsp; static inline struct amdgpu_device *drm_to_adev(struct =
drm_device <br>
*ddev) <br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c <br>
b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c <br>
index 164d6a9e9fbb..69c0a28deeac 100644 <br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c <br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c <br>
@@ -1609,6 +1609,100 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL, <br=
>
&nbsp;&nbsp; DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL, <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; amdgpu_debugfs_sclk_set, &quot;%llu\n&quot;); <br>
&nbsp;&nbsp; +static ssize_t amdgpu_reset_dump_register_list_read(struct fi=
le *f, <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; char __user *buf, size_t size, loff_t *pos) <br>
+{ <br>
+&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct amdgpu_device <b=
r>
*)file_inode(f)-&gt;i_private; <br>
+&nbsp;&nbsp;&nbsp; char reg_offset[11]; <br>
+&nbsp;&nbsp;&nbsp; int i, ret, len =3D 0; <br>
+ <br>
+&nbsp;&nbsp;&nbsp; if (*pos) <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0; <br>
+ <br>
+&nbsp;&nbsp;&nbsp; ret =3D down_read_killable(&amp;adev-&gt;reset_sem); <b=
r>
+ <br>
+&nbsp;&nbsp;&nbsp; if (ret) <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret; <o:p></o:p></p>
</blockquote>
<p class=3D"MsoNormal">We usually don't have an empty line between function=
 call and checking
<br>
the return code. <br>
<br>
<br>
<o:p></o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal">+ <br>
+&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;num_regs; i++) { <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; down_read(&amp;adev-&gt;reset_s=
em); <o:p></o:p></p>
</blockquote>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">That here will just c=
rash because we have already locked the semaphore
<br>
before the loop. <o:p></o:p></p>
</blockquote>
<p class=3D"MsoNormal">unfortunately it did not crash. Sorry I misunderstoo=
d your earlier comments.
<br>
<br>
<o:p></o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sprintf(=
reg_offset, &quot;0x%x &quot;, adev-&gt;reset_dump_reg_list[i]);
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; up_read(&amp;adev-&gt;reset_sem=
); <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D copy_to_user(buf + len,=
 reg_offset, strlen(reg_offset)); <br>
+ <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto er=
ror; <br>
+ <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; len +=3D strlen(reg_offset); <o=
:p></o:p></p>
</blockquote>
<p class=3D"MsoNormal">And here the down_read_killable() is missing. <br>
<br>
<br>
<o:p></o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; } <br>
+ <br>
+&nbsp;&nbsp;&nbsp; up_read(&amp;adev-&gt;reset_sem); <br>
+&nbsp;&nbsp;&nbsp; ret =3D copy_to_user(buf + len, &quot;\n&quot;, 1); <br=
>
+ <br>
+&nbsp;&nbsp;&nbsp; if (ret) <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAULT; <br>
+ <br>
+&nbsp;&nbsp;&nbsp; len++; <br>
+&nbsp;&nbsp;&nbsp; *pos +=3D len; <br>
+ <br>
+&nbsp;&nbsp;&nbsp; return len; <br>
+error: <br>
+&nbsp;&nbsp;&nbsp; up_read(&amp;adev-&gt;reset_sem); <br>
+&nbsp;&nbsp;&nbsp; return -EFAULT; <br>
+} <br>
+ <br>
+static ssize_t amdgpu_reset_dump_register_list_write(struct file *f, <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const c=
har __user *buf, size_t size, loff_t *pos) <br>
+{ <br>
+&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct amdgpu_device <b=
r>
*)file_inode(f)-&gt;i_private; <br>
+&nbsp;&nbsp;&nbsp; char *reg_offset, *reg, reg_temp[11]; <br>
+&nbsp;&nbsp;&nbsp; uint32_t *tmp; <br>
+&nbsp;&nbsp;&nbsp; int ret, i =3D 0, len =3D 0; <br>
+ <br>
+&nbsp;&nbsp;&nbsp; do { <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_offset =3D reg_temp; <o:p><=
/o:p></p>
</blockquote>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">I think you can just =
drop the reg_offset variable;
<o:p></o:p></p>
</blockquote>
<p class=3D"MsoNormal">strsep takes only pointer as input, this is workarou=
nd. <o:p>
</o:p></p>
</blockquote>
<p class=3D"MsoNormal"><br>
Ah, now I see what you are doing here. <br>
<br>
Please don't do it like that. Better use memchr() instead. <o:p></o:p></p>
</blockquote>
<p>memchr will not work. I couldn't find any other string API I can use.<o:=
p></o:p></p>
<p>other references similar to code:<o:p></o:p></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"line-height:14.25pt;background:white"><span=
 style=3D"font-size:10.5pt;font-family:Consolas;color:blue">static</span><s=
pan style=3D"font-size:10.5pt;font-family:Consolas;color:black">
</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:blue">voi=
d</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:black"> =
amdgpu_device_enable_virtual_display(</span><span style=3D"font-size:10.5pt=
;font-family:Consolas;color:blue">struct</span><span style=3D"font-size:10.=
5pt;font-family:Consolas;color:black">
 amdgpu_device *adev)<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"line-height:14.25pt;background:white"><span=
 style=3D"font-size:10.5pt;font-family:Consolas;color:black">{<o:p></o:p></=
span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"line-height:14.25pt;background:white"><span=
 style=3D"font-size:10.5pt;font-family:Consolas;color:black">&nbsp; &nbsp; =
adev-&gt;enable_virtual_display =3D
</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:blue">fal=
se</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:black">=
;<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal" style=3D"line-height:14.25pt;background:white"><span=
 style=3D"font-size:10.5pt;font-family:Consolas;color:black"><o:p>&nbsp;</o=
:p></span></p>
<div>
<p class=3D"MsoNormal" style=3D"line-height:14.25pt;background:white"><span=
 style=3D"font-size:10.5pt;font-family:Consolas;color:black">&nbsp; &nbsp;
</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:blue">if<=
/span><span style=3D"font-size:10.5pt;font-family:Consolas;color:black"> (a=
mdgpu_virtual_display) {<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"line-height:14.25pt;background:white"><span=
 style=3D"font-size:10.5pt;font-family:Consolas;color:black">&nbsp; &nbsp; =
&nbsp; &nbsp;
</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:blue">con=
st</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:black">
</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:blue">cha=
r</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:black"> =
*pci_address_name =3D pci_name(adev-&gt;pdev);<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"line-height:14.25pt;background:white"><span=
 style=3D"font-size:10.5pt;font-family:Consolas;color:black">&nbsp; &nbsp; =
&nbsp; &nbsp;
</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:blue">cha=
r</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:black"> =
*pciaddstr, *pciaddstr_tmp, *pciaddname_tmp, *pciaddname;<o:p></o:p></span>=
</p>
</div>
<p class=3D"MsoNormal" style=3D"line-height:14.25pt;background:white"><span=
 style=3D"font-size:10.5pt;font-family:Consolas;color:black"><o:p>&nbsp;</o=
:p></span></p>
<div>
<p class=3D"MsoNormal" style=3D"line-height:14.25pt;background:white"><span=
 style=3D"font-size:10.5pt;font-family:Consolas;color:black">&nbsp; &nbsp; =
&nbsp; &nbsp; pciaddstr =3D kstrdup(amdgpu_virtual_display,
</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:blue">GFP=
_KERNEL</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:bl=
ack">);<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"line-height:14.25pt;background:white"><span=
 style=3D"font-size:10.5pt;font-family:Consolas;color:black">&nbsp; &nbsp; =
&nbsp; &nbsp; pciaddstr_tmp =3D pciaddstr;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"line-height:14.25pt;background:white"><span=
 style=3D"font-size:10.5pt;font-family:Consolas;color:black">&nbsp; &nbsp; =
&nbsp; &nbsp;
</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:blue">whi=
le</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:black">=
 ((pciaddname_tmp =3D strsep(&amp;pciaddstr_tmp,
</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:#A31515">=
&quot;;&quot;</span><span style=3D"font-size:10.5pt;font-family:Consolas;co=
lor:black">))) {<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"line-height:14.25pt;background:white"><span=
 style=3D"font-size:10.5pt;font-family:Consolas;color:black">&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; pciaddname =3D strsep(&amp;pciaddname_tmp,
</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:#A31515">=
&quot;,&quot;</span><span style=3D"font-size:10.5pt;font-family:Consolas;co=
lor:black">);<o:p></o:p></span></p>
</div>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal"><br>
<br>
<o:p></o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(r=
eg_offset, 0, 11); <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D copy_from_user(reg_offs=
et, buf + len, min(11, <br>
((int)size-len))); <br>
+ <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto er=
ror_free; <br>
+ <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D strsep(&amp;reg_offset,=
 &quot; &quot;); <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D krealloc_array(tmp, 1, =
sizeof(uint32_t), GFP_KERNEL); <o:p></o:p></p>
</blockquote>
<p class=3D"MsoNormal">That must be krealloc_array(tmp, i, ... not krealloc=
_array(tmp, 1, ... !
<o:p></o:p></p>
</blockquote>
<p class=3D"MsoNormal">I thought it will append (if not it should have cras=
hed or some kernel dump)
<o:p></o:p></p>
</blockquote>
<p class=3D"MsoNormal"><br>
No, krealloc_array works similar to realloc() in userspace. <br>
<br>
You need to give it the full size of the necessary space. <br>
<br>
Regards, <br>
Christian. <br>
<br>
<br>
<o:p></o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal">Regards, <br>
Christian. <br>
<br>
<br>
<o:p></o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D =
kstrtouint(reg, 16, &amp;tmp[i]); <br>
+ <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto er=
ror_free; <br>
+ <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; len +=3D strlen(reg) + 1; <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i++; <br>
+ <br>
+&nbsp;&nbsp;&nbsp; } while (len &lt; size); <br>
+ <br>
+&nbsp;&nbsp;&nbsp; ret =3D down_write_killable(&amp;adev-&gt;reset_sem); <=
br>
+ <br>
+&nbsp;&nbsp;&nbsp; if (ret) <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free; <br>
+ <br>
+&nbsp;&nbsp;&nbsp; swap(adev-&gt;reset_dump_reg_list, tmp); <br>
+&nbsp;&nbsp;&nbsp; adev-&gt;num_regs =3D i; <br>
+&nbsp;&nbsp;&nbsp; up_write(&amp;adev-&gt;reset_sem); <br>
+&nbsp;&nbsp;&nbsp; ret =3D size; <br>
+ <br>
+error_free: <br>
+&nbsp;&nbsp;&nbsp; kfree(tmp); <br>
+&nbsp;&nbsp;&nbsp; return ret; <br>
+} <br>
+ <br>
+ <br>
+ <br>
+static const struct file_operations amdgpu_reset_dump_register_list =3D { =
<br>
+&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE, <br>
+&nbsp;&nbsp;&nbsp; .read =3D amdgpu_reset_dump_register_list_read, <br>
+&nbsp;&nbsp;&nbsp; .write =3D amdgpu_reset_dump_register_list_write, <br>
+&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek <br>
+}; <br>
+ <br>
&nbsp;&nbsp; int amdgpu_debugfs_init(struct amdgpu_device *adev) <br>
&nbsp;&nbsp; { <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dentry *root =3D adev_to_drm(ad=
ev)-&gt;primary-&gt;debugfs_root; <br>
@@ -1672,6 +1766,8 @@ int amdgpu_debugfs_init(struct amdgpu_device <br>
*adev) <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_test_ib_fops); <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;amdgpu_vm_in=
fo&quot;, 0444, root, adev, <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_vm_info_fops); <br>
+&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;amdgpu_reset_dump_register_li=
st&quot;, 0644, <br>
root, adev, <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; &amp;amdgpu_reset_dump_register_list); <br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;debugfs_vbios_blob.dat=
a =3D adev-&gt;bios; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;debugfs_vbios_blob.size =3D a=
dev-&gt;bios_size; <o:p></o:p></p>
</blockquote>
</blockquote>
<p class=3D"MsoNormal">&gt; <o:p></o:p></p>
</blockquote>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</blockquote>
</div>
</body>
</html>

--_000_DM6PR12MB38976DE0677BDF4DE12AAAA4F83A9DM6PR12MB3897namp_--

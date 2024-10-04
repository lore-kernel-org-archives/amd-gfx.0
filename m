Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAE7CFB447
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Oct 2024 13:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E6BC10E37F;
	Mon,  7 Oct 2024 13:06:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w7SVss4p";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71ED010EA4E
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 17:22:23 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-42cde6b5094so24020835e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Oct 2024 10:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728062541; x=1728667341; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PXo4Ndjvm3AA7Lf45/+oaFXui/jhz1H4w+r4nZGoww8=;
 b=w7SVss4pqDGLiSWJtF4AnrxlnAPxSd4xEzDvEXPdJIHNBubdtC4I1+55vBIUtBeGuK
 W76Z0tn/sMBPU57sVTMcCAplGbpStuKj/o0e54b1SEyR4Z6Aa9C9HlmrWLWv2C66jpa/
 burvtBekxjATgu96o5hbfNHArwOvPsCP5a2rPtLXCNZKSl+tW5EU0/ELQBq3JWlghsy2
 zrtxNCgrjIvagfBY964pkX0MN7qfK3tJVcHD/1MbkK9iT4ZNou56ArMYrksYSX7Q5Ap5
 m0MFFYd/X9FnVv36lu3OJRjx3OJcOdpg8ke+WSUZq1qoApVwFFqdvxMcVzCm3f1HA203
 ctEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728062541; x=1728667341;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PXo4Ndjvm3AA7Lf45/+oaFXui/jhz1H4w+r4nZGoww8=;
 b=aDaHQHfaIQrBBKRrk0H1LJG54WeYVRO07DyNos2TzruME5dvuNlUlT7zNrh0kpl4rL
 ITTtIHdkBXrCo55aIho8PAraYzy1FL+Uj5UYYvWfOyXgDYVZByQhxvCr2aJbmItvuGr5
 9IbpXHxQLCeBTkYY8rK4gF2OfeHdfnloxdQmEDm4g07vpkgzJoQHFOYzanPi6Ovqdd3T
 8EkdAl+7HhgPcqFuleuVqMAN3dUbqWhYzVF2wXD+nFGm8/P5M2bIOEbCRSjpnjQN/U2t
 zUQ8r1mn7U/y/YgyUQm6k5fbwo8fGI++chJaYzfH1cGypbHL5ruJcWU9SoCOZ91F2b3W
 ytZg==
X-Gm-Message-State: AOJu0Ywe19WnASMdLn58bQ7FiXk4luH1irhOBeTfLvgfYGMrg6s7l8BY
 fcCsGfhJsJP9gfkhvwEX4YLCljyhrtfLo17UjRC9hwH2/sq6AbUYw8UH4j9JdbU=
X-Google-Smtp-Source: AGHT+IGK8lWEtnlaRWGIAc6FDj67K8I8/Ekj8X8Qq5BoPFcEYTPFoWVbgDYGiIMriQoTOJuuCYJyrQ==
X-Received: by 2002:a05:6000:1b09:b0:37c:cc05:3bf8 with SMTP id
 ffacd0b85a97d-37d0e6d8386mr2341275f8f.9.1728062541578; 
 Fri, 04 Oct 2024 10:22:21 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d16972badsm93731f8f.103.2024.10.04.10.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 10:22:20 -0700 (PDT)
Date: Fri, 4 Oct 2024 20:22:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jack Xiao <Jack.Xiao@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amdgpu/mes: use ring for kernel queue submission
Message-ID: <b34479a5-5d53-4104-b8d5-975f34c73bbe@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 07 Oct 2024 13:06:21 +0000
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

Hello Jack Xiao,

Commit d0c423b64765 ("drm/amdgpu/mes: use ring for kernel queue
submission") from Mar 27, 2020 (linux-next), leads to the following
Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1240 amdgpu_mes_add_ring()
	warn: double unlock '&adev->mes.mutex_hidden' (orig line 1213)

drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
    1143 int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
    1144                         int queue_type, int idx,
    1145                         struct amdgpu_mes_ctx_data *ctx_data,
    1146                         struct amdgpu_ring **out)
    1147 {
    1148         struct amdgpu_ring *ring;
    1149         struct amdgpu_mes_gang *gang;
    1150         struct amdgpu_mes_queue_properties qprops = {0};
    1151         int r, queue_id, pasid;
    1152 
    1153         /*
    1154          * Avoid taking any other locks under MES lock to avoid circular
    1155          * lock dependencies.
    1156          */
    1157         amdgpu_mes_lock(&adev->mes);
    1158         gang = idr_find(&adev->mes.gang_id_idr, gang_id);
    1159         if (!gang) {
    1160                 DRM_ERROR("gang id %d doesn't exist\n", gang_id);
    1161                 amdgpu_mes_unlock(&adev->mes);
    1162                 return -EINVAL;
    1163         }
    1164         pasid = gang->process->pasid;
    1165 
    1166         ring = kzalloc(sizeof(struct amdgpu_ring), GFP_KERNEL);
    1167         if (!ring) {
    1168                 amdgpu_mes_unlock(&adev->mes);
    1169                 return -ENOMEM;
    1170         }
    1171 
    1172         ring->ring_obj = NULL;
    1173         ring->use_doorbell = true;
    1174         ring->is_mes_queue = true;
    1175         ring->mes_ctx = ctx_data;
    1176         ring->idx = idx;
    1177         ring->no_scheduler = true;
    1178 
    1179         if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
    1180                 int offset = offsetof(struct amdgpu_mes_ctx_meta_data,
    1181                                       compute[ring->idx].mec_hpd);
    1182                 ring->eop_gpu_addr =
    1183                         amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
    1184         }
    1185 
    1186         switch (queue_type) {
    1187         case AMDGPU_RING_TYPE_GFX:
    1188                 ring->funcs = adev->gfx.gfx_ring[0].funcs;
    1189                 ring->me = adev->gfx.gfx_ring[0].me;
    1190                 ring->pipe = adev->gfx.gfx_ring[0].pipe;
    1191                 break;
    1192         case AMDGPU_RING_TYPE_COMPUTE:
    1193                 ring->funcs = adev->gfx.compute_ring[0].funcs;
    1194                 ring->me = adev->gfx.compute_ring[0].me;
    1195                 ring->pipe = adev->gfx.compute_ring[0].pipe;
    1196                 break;
    1197         case AMDGPU_RING_TYPE_SDMA:
    1198                 ring->funcs = adev->sdma.instance[0].ring.funcs;
    1199                 break;
    1200         default:
    1201                 BUG();
    1202         }
    1203 
    1204         r = amdgpu_ring_init(adev, ring, 1024, NULL, 0,
    1205                              AMDGPU_RING_PRIO_DEFAULT, NULL);
    1206         if (r)
    1207                 goto clean_up_memory;
    1208 
    1209         amdgpu_mes_ring_to_queue_props(adev, ring, &qprops);
    1210 
    1211         dma_fence_wait(gang->process->vm->last_update, false);
    1212         dma_fence_wait(ctx_data->meta_data_va->last_pt_update, false);
    1213         amdgpu_mes_unlock(&adev->mes);
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    1214 
    1215         r = amdgpu_mes_add_hw_queue(adev, gang_id, &qprops, &queue_id);
    1216         if (r)
    1217                 goto clean_up_ring;
                         ^^^^^^^^^^^^^^^^^^

    1218 
    1219         ring->hw_queue_id = queue_id;
    1220         ring->doorbell_index = qprops.doorbell_off;
    1221 
    1222         if (queue_type == AMDGPU_RING_TYPE_GFX)
    1223                 sprintf(ring->name, "gfx_%d.%d.%d", pasid, gang_id, queue_id);
    1224         else if (queue_type == AMDGPU_RING_TYPE_COMPUTE)
    1225                 sprintf(ring->name, "compute_%d.%d.%d", pasid, gang_id,
    1226                         queue_id);
    1227         else if (queue_type == AMDGPU_RING_TYPE_SDMA)
    1228                 sprintf(ring->name, "sdma_%d.%d.%d", pasid, gang_id,
    1229                         queue_id);
    1230         else
    1231                 BUG();
    1232 
    1233         *out = ring;
    1234         return 0;
    1235 
    1236 clean_up_ring:
    1237         amdgpu_ring_fini(ring);
    1238 clean_up_memory:
    1239         kfree(ring);
--> 1240         amdgpu_mes_unlock(&adev->mes);
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    1241         return r;
    1242 }

regards,
dan carpenter

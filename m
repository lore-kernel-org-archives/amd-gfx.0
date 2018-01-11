From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Move to gtt before cpu
 accesses dma buf.
Date: Thu, 11 Jan 2018 09:42:50 +0300
Message-ID: <20180111064250.serwwuqpqr5gycjn@mwanda>
References: <1515100355-6893-1-git-send-email-Samuel.Li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <kbuild-bounces@lists.01.org>
Content-Disposition: inline
In-Reply-To: <1515100355-6893-1-git-send-email-Samuel.Li@amd.com>
List-Unsubscribe: <https://lists.01.org/mailman/options/kbuild>,
 <mailto:kbuild-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/kbuild/>
List-Post: <mailto:kbuild@lists.01.org>
List-Help: <mailto:kbuild-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/kbuild>,
 <mailto:kbuild-request@lists.01.org?subject=subscribe>
Errors-To: kbuild-bounces@lists.01.org
Sender: "kbuild" <kbuild-bounces@lists.01.org>
To: kbuild@01.org
Cc: Samuel Li <Samuel.Li@amd.com>, amd-gfx@lists.freedesktop.org, kbuild-all@01.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org


Hi Samuel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on v4.15-rc7 next-20180110]
[if your patch is applied to the wrong git tree, please drop us a note to h=
elp improve the system]

url:    https://github.com/0day-ci/linux/commits/Samuel-Li/drm-amdgpu-allow=
-framebuffer-in-GART-memory-as-well/20180106-050432
base:   git://people.freedesktop.org/~airlied/linux.git drm-next

smatch warnings:
drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c:226 amdgpu_gem_prime_export() err=
or: 'buf' dereferencing possible ERR_PTR()

# https://github.com/0day-ci/linux/commit/6aa2afecb5a3efc463d20002383939957=
1404843
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 6aa2afecb5a3efc463d200023839399571404843
vim +/buf +226 drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c

6aa2afecb5 Samuel Li       2018-01-04  211  =

d38ceaf99e Alex Deucher    2015-04-20  212  struct dma_buf *amdgpu_gem_prim=
e_export(struct drm_device *dev,
d38ceaf99e Alex Deucher    2015-04-20  213  					struct drm_gem_object *gob=
j,
d38ceaf99e Alex Deucher    2015-04-20  214  					int flags)
d38ceaf99e Alex Deucher    2015-04-20  215  {
d38ceaf99e Alex Deucher    2015-04-20  216  	struct amdgpu_bo *bo =3D gem_t=
o_amdgpu_bo(gobj);
4b277247b1 Christian K=F6nig 2017-11-13  217  	struct dma_buf *buf;
d38ceaf99e Alex Deucher    2015-04-20  218  =

e1eb899b45 Christian K=F6nig 2017-08-25  219  	if (amdgpu_ttm_tt_get_usermm=
(bo->tbo.ttm) ||
e1eb899b45 Christian K=F6nig 2017-08-25  220  	    bo->flags & AMDGPU_GEM_C=
REATE_VM_ALWAYS_VALID)
d38ceaf99e Alex Deucher    2015-04-20  221  		return ERR_PTR(-EPERM);
d38ceaf99e Alex Deucher    2015-04-20  222  =

4b277247b1 Christian K=F6nig 2017-11-13  223  	buf =3D drm_gem_prime_export=
(dev, gobj, flags);
4b277247b1 Christian K=F6nig 2017-11-13  224  	if (!IS_ERR(buf))
4b277247b1 Christian K=F6nig 2017-11-13  225  		buf->file->f_mapping =3D de=
v->anon_inode->i_mapping;
6aa2afecb5 Samuel Li       2018-01-04 @226  	buf->ops =3D &amdgpu_dmabuf_op=
s;
6aa2afecb5 Samuel Li       2018-01-04  227  =

4b277247b1 Christian K=F6nig 2017-11-13  228  	return buf;
d38ceaf99e Alex Deucher    2015-04-20  229  }
6aa2afecb5 Samuel Li       2018-01-04  230  =
